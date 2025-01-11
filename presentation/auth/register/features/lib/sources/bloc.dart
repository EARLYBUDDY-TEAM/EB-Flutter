part of '../eb_register_feature.dart';

final class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final EBAuthRepository _ebAuthRepository;
  final EBTokenRepository _tokenRepository;
  final HomeDelegate _homeDelegate;
  final RootDelegate _rootDelegate;
  final LoadingDelegate _loadingDelegate;
  final SecureStorage _secureStorage;

  RegisterBloc({
    required EBAuthRepository ebAuthRepository,
    required EBTokenRepository tokenRepository,
    required HomeDelegate homeDelegate,
    required RootDelegate rootDelegate,
    required LoadingDelegate loadingDelegate,
    SecureStorage? secureStorage,
  })  : _ebAuthRepository = ebAuthRepository,
        _tokenRepository = tokenRepository,
        _homeDelegate = homeDelegate,
        _rootDelegate = rootDelegate,
        _loadingDelegate = loadingDelegate,
        _secureStorage = secureStorage ?? SecureStorage.shared,
        super(const RegisterState()) {
    on<ChangeNickName>(_onChangeNickName);
    on<ChangeEmail>(_onChangeEmail);
    on<ChangePassword>(_onChangePassword);
    on<ChangePasswordConfirm>(_onChangePasswordConfirm);
    on<PressRegisterButton>(_onPressRegisterButton);
    on<PressAlertOkButton>(_onPressAlertOkButton);
    on<PressRecommendNickNameButton>(_onPressRecommendNickNameButton);
  }
}

extension on RegisterBloc {
  void _onChangeNickName(
    ChangeNickName event,
    Emitter<RegisterState> emit,
  ) {
    final name = NickNameFormz(value: event.nickName);
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
  Future<void> _writeLoginInfoInSecureStorage({
    required String email,
    required String password,
  }) async {
    try {
      await _secureStorage.write(
        key: SecureStorageKey.email,
        value: email,
      );

      await _secureStorage.write(
        key: SecureStorageKey.password,
        value: password,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _onPressRegisterButton(
    PressRegisterButton event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.inputIsValid) {
      _loadingDelegate.set();
      emit(state.copyWith(status: RegisterStatus.inProgress));
      final email = state.emailState.email.value;
      final password = state.passwordState.password.value;

      final compressedNickName =
          compressName(state.nickNameState.nickName.value);
      final NetworkResponse<EmptyDTO> registerResult =
          await _ebAuthRepository.register(
        nickName: compressedNickName,
        email: email,
        password: password,
      );

      switch (registerResult) {
        case SuccessResponse():
          final fcmToken = await NotificationManager.getFCMToken() ?? '';

          final NetworkResponse<LoginResult> loginResponse =
              await _ebAuthRepository.logIn(
            email: email,
            password: password,
            fcmToken: fcmToken,
          );
          switch (loginResponse) {
            case SuccessResponse():
              emit(state.copyWith(status: RegisterStatus.initial));
              await _writeLoginInfoInSecureStorage(
                email: email,
                password: password,
              );
              final LoginResult loginResult = loginResponse.model;
              await _tokenRepository.saveToken(loginResult.token);
              await _secureStorage.write(
                key: SecureStorageKey.nickName,
                value: loginResult.nickName,
              );

              _loadingDelegate.dismiss();

              _rootDelegate.authStatus.add(Authenticated());
              _homeDelegate.registerStatus.add(compressedNickName);
            case FailureResponse():
              _loadingDelegate.dismiss();
              emit(state.copyWith(status: RegisterStatus.onErrorLogin));
          }
        case FailureResponse():
          _loadingDelegate.dismiss();
          switch (registerResult.statusCode) {
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

extension on RegisterBloc {
  void _onPressRecommendNickNameButton(
    PressRecommendNickNameButton event,
    Emitter<RegisterState> emit,
  ) {
    final String recommendName = NameGenerator.random();
    add(ChangeNickName(recommendName));
  }
}
