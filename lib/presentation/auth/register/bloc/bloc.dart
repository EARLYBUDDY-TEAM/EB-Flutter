import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final email = Email(value: event.email);
    emit(state.copyWith(email: email));
  }

  void _onChangePassword(
    ChangePassword event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password(value: event.password);
    final passwordConfirm =
        state.passwordConfirm.copyWith(origin: event.password);
    emit(
      state.copyWith(
        password: password,
        passwordConfirm: passwordConfirm,
      ),
    );
  }

  void _onChangePasswordConfirm(
    ChangePasswordConfirm event,
    Emitter<RegisterState> emit,
  ) {
    final passwordConfirm =
        state.passwordConfirm.copyWith(value: event.passwordConfirm);
    emit(
      state.copyWith(
        passwordConfirm: passwordConfirm,
      ),
    );
  }

  void onPressRegisterButton(
    PressRegisterButton event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.inputIsValid) {
      emit(state.copyWith(status: RegisterStatus.inProgress));

      final bool isSuccess = await _authRepository.register(
        email: state.email.value,
        password: state.password.value,
      );

      if (!isSuccess) {
        emit(
          state.copyWith(status: RegisterStatus.onError),
        );
      }
    }
  }
}
