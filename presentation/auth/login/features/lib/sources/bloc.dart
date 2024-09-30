part of '../eb_login_feature.dart';

final class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final EBAuthRepository _authRepository;
  final TokenRepository _tokenRepository;
  final HomeDelegate _homeDelegate;
  final RootDelegate _rootDelegate;
  final LoadingDelegate _loadingDelegate;

  late StreamSubscription<BaseStatus> _tokenStatusSubscription;

  LoginBloc({
    required EBAuthRepository authRepository,
    required TokenRepository tokenRepository,
    required HomeDelegate homeDelegate,
    required LoginDelegate loginDelegate,
    required RootDelegate rootDelegate,
    required LoadingDelegate loadingDelegate,
  })  : _authRepository = authRepository,
        _tokenRepository = tokenRepository,
        _homeDelegate = homeDelegate,
        _rootDelegate = rootDelegate,
        _loadingDelegate = loadingDelegate,
        super(const LoginState()) {
    on<ChangeEmail>(_onChangeEmail);
    on<ChangePassword>(_onChangePassword);
    on<PressLoginButton>(_onPressLoginButton);
    on<PressAlertOkButton>(_onPressAlertOkButton);
    on<SetTokenStatus>(_onSetTokenStatus);

    _tokenStatusSubscription = loginDelegate.tokenStatus.listen(
      (status) => add(SetTokenStatus(status: status)),
    );
  }

  @override
  Future<void> close() {
    _tokenStatusSubscription.cancel();
    return super.close();
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
  Future<void> _onPressLoginButton(
    PressLoginButton event,
    Emitter<LoginState> emit,
  ) async {
    if (state.inputIsValid) {
      emit(state.copyWith(status: LoginStatus.inProgress));
      _loadingDelegate.set();

      final Result result = await _authRepository.logIn(
        email: state.emailState.email.value,
        password: state.passwordState.password.value,
      );

      switch (result) {
        case Success():
          emit(state.copyWith(status: LoginStatus.initial));
          Token token = result.success.model;
          await _tokenRepository.saveToken(token);
          _loadingDelegate.dismiss();
          _homeDelegate.loginStatus.add(BaseStatus.success);
          _rootDelegate.authStatus.add(Authenticated());
        case Failure():
          _loadingDelegate.dismiss();
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
    emit(state.copyWith(status: LoginStatus.initial));
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
