part of '../eb_register_feature.dart';

final class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final EBAuthRepository _authRepository;
  final HomeDelegate _homeDelegate;

  RegisterBloc({
    EBAuthRepository? authRepository,
    HomeDelegate? homeDelegate,
  })  : _authRepository = authRepository ?? EBAuthRepository(),
        _homeDelegate = homeDelegate ?? HomeDelegate(),
        super(const RegisterState()) {
    on<ChangeEmail>(_onChangeEmail);
    on<ChangePassword>(_onChangePassword);
    on<ChangePasswordConfirm>(_onChangePasswordConfirm);
    on<PressRegisterButton>(_onPressRegisterButton);
    on<PressAlertOkButton>(_onPressAlertOkButton);
  }

  void _onChangeEmail(
    ChangeEmail event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email(value: event.email);
    EmailFormStatus status;
    if (email.value.isEmpty) {
      status = EmailFormStatus.initial;
    } else {
      status = email.isValid ? EmailFormStatus.typing : EmailFormStatus.onError;
    }
    final emailState = state.emailState.copyWith(
      email: email,
      status: status,
    );
    emit(state.copyWith(emailState: emailState));
  }

  void _onChangePassword(
    ChangePassword event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password(value: event.password);
    PasswordFormStatus passwordStatus;
    if (password.value.isEmpty) {
      passwordStatus = PasswordFormStatus.initial;
    } else {
      passwordStatus = password.isValid
          ? PasswordFormStatus.typing
          : PasswordFormStatus.onError;
    }
    final passwordState = PasswordState(
      password: password,
      status: passwordStatus,
    );

    final passwordConfirm = state.passwordConfirmState.passwordConfirm
        .copyWith(origin: event.password);
    PasswordConfirmFormStatus passwordConfirmStatus;
    if (passwordConfirm.value.isEmpty) {
      passwordConfirmStatus = PasswordConfirmFormStatus.initial;
    } else {
      passwordConfirmStatus = passwordConfirm.isValid
          ? PasswordConfirmFormStatus.typing
          : PasswordConfirmFormStatus.onError;
    }
    final passwordConfirmState = state.passwordConfirmState.copyWith(
      passwordConfirm: passwordConfirm,
      status: passwordConfirmStatus,
    );
    emit(
      state.copyWith(
        passwordState: passwordState,
        passwordConfirmState: passwordConfirmState,
      ),
    );
  }

  void _onChangePasswordConfirm(
    ChangePasswordConfirm event,
    Emitter<RegisterState> emit,
  ) {
    final passwordConfirm = state.passwordConfirmState.passwordConfirm
        .copyWith(value: event.passwordConfirm);
    PasswordConfirmFormStatus status;
    if (passwordConfirm.value.isEmpty) {
      status = PasswordConfirmFormStatus.initial;
    } else {
      status = passwordConfirm.isValid
          ? PasswordConfirmFormStatus.typing
          : PasswordConfirmFormStatus.onError;
    }

    final passwordConfirmState = PasswordConfirmState(
      passwordConfirm: passwordConfirm,
      status: status,
    );
    emit(
      state.copyWith(passwordConfirmState: passwordConfirmState),
    );
  }

  void _onPressRegisterButton(
    PressRegisterButton event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.inputIsValid) {
      emit(state.copyWith(status: RegisterStatus.inProgress));

      final Result registerResult = await _authRepository.register(
        email: state.emailState.email.value,
        password: state.passwordState.password.value,
      );

      switch (registerResult) {
        case Success():
          final Result loginResult = await _authRepository.logIn(
            email: state.emailState.email.value,
            password: state.passwordState.password.value,
          );
          switch (loginResult) {
            case Success():
              emit(state.copyWith(status: RegisterStatus.initial));
              Token token = loginResult.success.model;
              _homeDelegate.registerStatus.add(BaseStatus.success);
              _authRepository.addAuthenticate(token);
            case Failure():
              emit(state.copyWith(status: RegisterStatus.onErrorLogin));
          }
        case Failure():
          switch (registerResult.failure.statusCode) {
            case (400):
              emit(
                  state.copyWith(status: RegisterStatus.onErrorNotCorrectUser));
            case (401):
              emit(state.copyWith(status: RegisterStatus.onErrorExsitUser));
            default:
              emit(state.copyWith(status: RegisterStatus.onErrorUnknown));
          }
      }
    } else {
      emit(state.copyWith(status: RegisterStatus.onErrorNotCorrectUser));
    }
  }

  void _onPressAlertOkButton(
    PressAlertOkButton event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(status: RegisterStatus.initial));
  }
}
