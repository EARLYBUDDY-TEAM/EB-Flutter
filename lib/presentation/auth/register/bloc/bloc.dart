import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/domain/domain_model/auth/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'event.dart';
part 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required EBAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const RegisterState()) {
    on<ChangeEmail>(_onChangeEmail);
    on<ChangePassword>(_onChangePassword);
    on<ChangePasswordConfirm>(_onChangePasswordConfirm);
    on<PressRegisterButton>(onPressRegisterButton);
  }

  final EBAuthRepository _authRepository;

  void _onChangeEmail(
    ChangeEmail event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    final isValidEmail = Formz.validate([email]);

    emit(
      state.copyWith(
        emailState:
            state.emailState.copyWith(email: email, isValidEmail: isValidEmail),
        inputIsValid: Formz.validate([email, state.passwordState.password]) &&
            state.passwordState.password ==
                state.passwordConfirmState.passwordConfirm,
      ),
    );
  }

  void _onChangePassword(
    ChangePassword event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    final isValidPassword = Formz.validate([password]);

    emit(
      state.copyWith(
        passwordState: state.passwordState
            .copyWith(password: password, isValidPassword: isValidPassword),
        inputIsValid: Formz.validate([password, state.emailState.email]) &&
            password == state.passwordConfirmState.passwordConfirm,
      ),
    );
  }

  void _onChangePasswordConfirm(
    ChangePasswordConfirm event,
    Emitter<RegisterState> emit,
  ) {
    final passwordConfirm = Password.dirty(event.passwordConfirm);
    final isValidPassword = state.passwordState.password == passwordConfirm;

    emit(
      state.copyWith(
        passwordConfirmState: state.passwordConfirmState.copyWith(
            passwordConfirm: passwordConfirm,
            isValidPasswordConfirm: isValidPassword),
        inputIsValid: Formz.validate(
                [state.passwordState.password, state.emailState.email]) &&
            isValidPassword,
      ),
    );
  }

  void onPressRegisterButton(
    PressRegisterButton event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.inputIsValid) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.inProgress,
        ),
      );
      final bool isSuccess = await _authRepository.register(
        email: state.emailState.email.value,
        password: state.passwordState.password.value,
      );

      if (!isSuccess) {
        state.copyWith(status: FormzSubmissionStatus.failure);
      }
    }
  }
}
