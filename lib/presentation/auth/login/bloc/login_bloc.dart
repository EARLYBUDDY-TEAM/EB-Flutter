import 'package:earlybuddy/domain/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/presentation/auth/auth_model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final EBAuthRepository _authRepository;

  LoginBloc({
    required EBAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(onEmailChanged);
    on<LoginPasswordChanged>(onPasswordChanged);
    on<LoginPressed>(onLoginPressed);
  }

  void onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        emailState: state.emailState.copyWith(email: email, isError: false),
        inputIsValid: Formz.validate([email, state.passwordState.password]),
      ),
    );
  }

  void onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        passwordState:
            state.passwordState.copyWith(password: password, isError: false),
        inputIsValid: Formz.validate([password, state.emailState.email]),
      ),
    );
  }

  Future<void> onLoginPressed(
    LoginPressed event,
    Emitter<LoginState> emit,
  ) async {
    if (state.inputIsValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authRepository.logIn(
          email: state.emailState.email.value,
          password: state.passwordState.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            emailState: state.emailState.copyWith(isError: true),
            passwordState: state.passwordState.copyWith(isError: true),
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          emailState: state.emailState.copyWith(isError: true),
          passwordState: state.passwordState.copyWith(isError: true),
        ),
      );
    }
  }

  void onLoginRegisterPressed(
    LoginRegisterPressed event,
    Emitter<LoginState> emit,
  ) {
    // Navigator.of(context).push(
    //         MaterialPageRoute(builder: (context) => const RegisterView()));
  }
}
