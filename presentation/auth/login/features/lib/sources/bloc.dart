part of '../eb_login_feature.dart';

final class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final EBAuthRepository _authRepository;
  final TokenRepository _tokenRepository;
  final HomeDelegate _homeDelegate;
  final RootDelegate _rootDelegate;
  final LoadingDelegate _loadingDelegate;
  final SecureStorage _secureStorage;

  late StreamSubscription<BaseStatus> _tokenStatusSubscription;
  late StreamSubscription<void> _completeLogoutSubscription;

  LoginBloc({
    required EBAuthRepository authRepository,
    required TokenRepository tokenRepository,
    required HomeDelegate homeDelegate,
    required LoginDelegate loginDelegate,
    required RootDelegate rootDelegate,
    required LoadingDelegate loadingDelegate,
    required SecureStorage secureStorage,
  })  : _authRepository = authRepository,
        _tokenRepository = tokenRepository,
        _homeDelegate = homeDelegate,
        _rootDelegate = rootDelegate,
        _loadingDelegate = loadingDelegate,
        _secureStorage = secureStorage,
        super(const LoginState()) {
    on<ChangeEmail>(_onChangeEmail);
    on<ChangePassword>(_onChangePassword);
    on<PressLoginButton>(_onPressLoginButton);
    on<PressAlertOkButton>(_onPressAlertOkButton);
    on<PressAutoLoginButton>(_onPressAutoLoginButton);
    on<SetTokenStatus>(_onSetTokenStatus);
    on<SetAutoLogin>(_onSetAutoLogin);
    on<CompleteLogout>(_onShowLogoutSnackBar);

    _tokenStatusSubscription = loginDelegate.tokenStatus.listen(
      (status) => add(SetTokenStatus(status: status)),
    );

    _completeLogoutSubscription = loginDelegate.completeLogout.listen(
      (status) => add(CompleteLogout(status: status)),
    );
  }

  @override
  Future<void> close() async {
    await _tokenStatusSubscription.cancel();
    await _completeLogoutSubscription.cancel();
    await super.close();
  }
}

extension on LoginBloc {
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
}

extension on LoginBloc {
  Future<void> _writeAutoLoginInfoInSecureStorage({
    required bool isAutoLogin,
    required String email,
    required String password,
  }) async {
    await _secureStorage.write(
      key: SecureStorageKey.email,
      value: email,
    );

    await _secureStorage.write(
      key: SecureStorageKey.password,
      value: password,
    );

    if (isAutoLogin == false) {
      return;
    }

    await _secureStorage.write(
      key: SecureStorageKey.isAutoLogin,
      value: 'true',
    );
  }

  Future<void> _loginAction({
    required Emitter<LoginState> emit,
    required _LoginInfo loginInfo,
    Future<void> Function()? successAction,
  }) async {
    _loadingDelegate.set();
    emit(state.copyWith(loginStatus: LoginStatus.inProgress));

    final NetworkResponse<Token> result = await _authRepository.logIn(
      email: loginInfo.email,
      password: loginInfo.password,
    );

    switch (result) {
      case SuccessResponse():
        emit(state.copyWith(loginStatus: LoginStatus.initial));

        if (successAction != null) {
          await successAction();
        }

        final Token token = result.model;
        await _tokenRepository.saveToken(token);

        _loadingDelegate.dismiss();
        _homeDelegate.loginStatus.add(BaseStatus.success);
        _rootDelegate.authStatus.add(Authenticated());
      case FailureResponse():
        _loadingDelegate.dismiss();
        await _secureStorage.delete(key: SecureStorageKey.isAutoLogin);
        _failLoginAction(emit);
    }
  }

  void _failLoginAction(
    Emitter<LoginState> emit,
  ) {
    final emailState =
        state.emailState.copyWith(status: EmailFormStatus.onError);
    final passwordState =
        state.passwordState.copyWith(status: PasswordFormStatus.onError);
    emit(
      state.copyWith(
        loginStatus: LoginStatus.onError,
        emailState: emailState,
        passwordState: passwordState,
      ),
    );
  }

  Future<void> _onPressLoginButton(
    PressLoginButton event,
    Emitter<LoginState> emit,
  ) async {
    final email = state.emailState.email.value;
    final password = state.passwordState.password.value;
    final loginInfo = _LoginInfo(
      email: email,
      password: password,
    );

    Future<void> successAction() async {
      await _writeAutoLoginInfoInSecureStorage(
        isAutoLogin: state.isAutoLogin,
        email: email,
        password: password,
      );
    }

    if (state.inputIsValid) {
      await _loginAction(
        emit: emit,
        successAction: successAction,
        loginInfo: loginInfo,
      );
    } else {
      _failLoginAction(emit);
    }
  }
}

extension on LoginBloc {
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
}

extension on LoginBloc {
  void _onPressAlertOkButton(
    PressAlertOkButton event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(loginStatus: LoginStatus.initial));
  }
}

extension on LoginBloc {
  void _onSetTokenStatus(
    SetTokenStatus event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(tokenStatus: event.status));
  }
}

extension on LoginBloc {
  Future<void> _onPressAutoLoginButton(
    PressAutoLoginButton event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        isAutoLogin: event.isAutoLogin,
      ),
    );
  }
}

extension on LoginBloc {
  Future<_LoginInfo?> _getLoginInfo() async {
    try {
      final email = await _secureStorage.read(key: SecureStorageKey.email);
      final password =
          await _secureStorage.read(key: SecureStorageKey.password);

      return _LoginInfo(
        email: email,
        password: password,
      );
    } catch (e) {
      return null;
    }
  }

  Future<bool> _isAutoLogin() async {
    try {
      final isAutoLogin =
          await _secureStorage.read(key: SecureStorageKey.isAutoLogin);

      return isAutoLogin == 'true';
    } catch (e) {
      return false;
    }
  }

  Future<void> _onSetAutoLogin(
    SetAutoLogin event,
    Emitter<LoginState> emit,
  ) async {
    final isAutoLogin = await _isAutoLogin();
    if (!isAutoLogin) {
      return;
    }

    final loginInfo = await _getLoginInfo();
    if (loginInfo == null) {
      return;
    }

    await _loginAction(
      emit: emit,
      loginInfo: loginInfo,
    );
  }
}

extension on LoginBloc {
  void _onShowLogoutSnackBar(
    CompleteLogout event,
    Emitter<LoginState> emit,
  ) {
    if (event.status != BaseStatus.success) {
      return;
    }

    final completeLogout = !state.completeLogout;
    emit(state.copyWith(completeLogout: completeLogout));
  }
}
