import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'state/state.dart';
part 'state/email_state.dart';
part 'state/password_state.dart';
part 'event.dart';

final class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final EBAuthRepository _authRepository;

  LoginBloc({
    required EBAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginState()) {
    on<ChangeEmail>(_onChangeEmail);
    on<ChangePassword>(_onChangePassword);
    on<PressLoginButton>(_onPressLoginButton);
    on<PressAlertOkButton>(_onPressAlertOkButton);
  }

  void _onChangeEmail(
    ChangeEmail event,
    Emitter<LoginState> emit,
  ) {
    final status =
        event.email.isEmpty ? EmailFormStatus.initial : EmailFormStatus.typing;
    final emailState = state.emailState.copyWith(
      email: Email(value: event.email),
      status: status,
    );
    emit(state.copyWith(emailState: emailState));
  }

  void _onChangePassword(
    ChangePassword event,
    Emitter<LoginState> emit,
  ) {
    final status = event.password.isEmpty
        ? PasswordFormStatus.initial
        : PasswordFormStatus.typing;
    final passwordState = state.passwordState.copyWith(
      password: Password(value: event.password),
      status: status,
    );
    emit(state.copyWith(passwordState: passwordState));
  }

  Future<void> _onPressLoginButton(
    PressLoginButton event,
    Emitter<LoginState> emit,
  ) async {
    if (state.inputIsValid) {
      emit(state.copyWith(status: LoginStatus.inProgress));

      final int? statusCode = await _authRepository.logIn(
        email: state.emailState.email.value,
        password: state.passwordState.password.value,
      );

      switch (statusCode) {
        case (null):
          emit(state.copyWith(status: LoginStatus.initial));
        default:
          final emailState =
              state.emailState.copyWith(status: EmailFormStatus.onError);
          final passwordState =
              state.passwordState.copyWith(status: PasswordFormStatus.onError);
          emit(
            state.copyWith(
              status: LoginStatus.onError,
              emailState: emailState,
              passwordState: passwordState,
            ),
          );
      }
    } else {
      final emailState =
          state.emailState.copyWith(status: EmailFormStatus.onError);
      final passwordState =
          state.passwordState.copyWith(status: PasswordFormStatus.onError);
      emit(
        state.copyWith(
          status: LoginStatus.onError,
          emailState: emailState,
          passwordState: passwordState,
        ),
      );
    }
  }

  void _onPressAlertOkButton(
    PressAlertOkButton event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(status: LoginStatus.initial));
  }
}
