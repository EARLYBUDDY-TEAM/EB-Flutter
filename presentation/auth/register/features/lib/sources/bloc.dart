part of '../eb_register_feature.dart';

final class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final EBAuthRepository _authRepository;
  final TokenRepository _tokenRepository;
  final HomeDelegate _homeDelegate;
  final RootDelegate _rootDelegate;
  final LoadingDelegate _loadingDelegate;

  RegisterBloc({
    required EBAuthRepository authRepository,
    required TokenRepository tokenRepository,
    required HomeDelegate homeDelegate,
    required RootDelegate rootDelegate,
    required LoadingDelegate loadingDelegate,
  })  : _authRepository = authRepository,
        _tokenRepository = tokenRepository,
        _homeDelegate = homeDelegate,
        _rootDelegate = rootDelegate,
        _loadingDelegate = loadingDelegate,
        super(const RegisterState()) {
    on<ChangeName>(_onChangeName);
    on<ChangeEmail>(_onChangeEmail);
    on<ChangePassword>(_onChangePassword);
    on<ChangePasswordConfirm>(_onChangePasswordConfirm);
    on<PressRegisterButton>(_onPressRegisterButton);
    on<PressAlertOkButton>(_onPressAlertOkButton);
  }
}

extension on RegisterBloc {
  void _onChangeName(
    ChangeName event,
    Emitter<RegisterState> emit,
  ) {
    final name = NickNameFormz(value: event.name);
    TextFieldStatus status;
    if (name.value.isEmpty) {
      status = TextFieldStatus.initial;
    } else {
      status = name.isValid ? TextFieldStatus.typing : TextFieldStatus.onError;
    }
    final nameState = state.nickNameState.copyWith(
      nickName: name,
      status: status,
    );
    emit(state.copyWith(nickNameState: nameState));
  }
}

extension on RegisterBloc {
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
}

extension on RegisterBloc {
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
}

extension on RegisterBloc {
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
}

extension on RegisterBloc {
  void _onPressRegisterButton(
    PressRegisterButton event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.inputIsValid) {
      _loadingDelegate.set();
      emit(state.copyWith(status: RegisterStatus.inProgress));

      final compressedName = compressName(state.nickNameState.nickName.value);
      final Result registerResult = await _authRepository.register(
        name: compressedName,
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
              await _tokenRepository.saveToken(token);
              _loadingDelegate.dismiss();
              _rootDelegate.authStatus.add(Authenticated());
              _homeDelegate.registerStatus.add(BaseStatus.success);
            case Failure():
              _loadingDelegate.dismiss();
              emit(state.copyWith(status: RegisterStatus.onErrorLogin));
          }
        case Failure():
          _loadingDelegate.dismiss();
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

  String compressName(String name) {
    var newName = name.trim();
    final whitespaceRE = RegExp(r"(?! )\s+| \s+");
    newName = newName.split(whitespaceRE).join(" ");
    return newName;
  }
}

extension on RegisterBloc {
  void _onPressAlertOkButton(
    PressAlertOkButton event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(status: RegisterStatus.initial));
  }
}
