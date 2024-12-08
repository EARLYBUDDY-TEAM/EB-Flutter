part of '../eb_menu_feature.dart';

final class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final LoadingDelegate _loadingDelegate;
  final RootDelegate _rootDelegate;
  final LoginDelegate _loginDelegate;
  final SecureStorage _secureStorage;
  final EBAuthRepository _ebAuthRepository;

  MenuBloc({
    required LoadingDelegate loadingDelegate,
    required RootDelegate rootDelegate,
    required LoginDelegate loginDelegate,
    required EBAuthRepository ebAuthRepository,
    SecureStorage? secureStorage,
  })  : _loadingDelegate = loadingDelegate,
        _rootDelegate = rootDelegate,
        _loginDelegate = loginDelegate,
        _ebAuthRepository = ebAuthRepository,
        _secureStorage = secureStorage ?? SecureStorage(),
        super(const MenuState()) {
    on<PressLogoutButton>(_onPressLogoutButton);
    on<ChangePassword>(_onChangePassword);
    on<ChangePasswordConfirm>(_onChangePasswordConfirm);
    on<PressChangePasswordButton>(_onPressChangePasswordButton);
    on<SetChangePasswordStatus>(_onSetChangePasswordStatus);
  }
}

extension on MenuBloc {
  Future<void> _onPressLogoutButton(
    PressLogoutButton event,
    Emitter<MenuState> emit,
  ) async {
    final toDelete = [
      SecureStorageKey.isAutoLogin,
      SecureStorageKey.email,
      SecureStorageKey.password,
      SecureStorageKey.accessToken,
      SecureStorageKey.refreshToken,
    ];

    for (final key in toDelete) {
      try {
        await _secureStorage.delete(key: key);
      } catch (e) {
        log(e.toString());
      }
    }

    _rootDelegate.authStatus.add(UnAuthenticated());
    _loginDelegate.completeLogout.add(BaseStatus.success);
  }
}

extension on MenuBloc {
  void _onChangePassword(
    ChangePassword event,
    Emitter<MenuState> emit,
  ) {
    final passwordString = event.password;
    final password = Password(value: passwordString);
    var status = password.isValid ? FormStatus.complete : FormStatus.inComplete;
    if (passwordString.isEmpty) {
      status = FormStatus.init;
    }
    final passwordState = state.passwordState.copyWith(
      password: password,
      status: status,
    );
    emit(
      state.copyWith(
        passwordState: passwordState,
      ),
    );

    final passwordConfirm = state.passwordConfirmState.passwordConfirm;
    add(ChangePasswordConfirm(passwordConfirm: passwordConfirm));

    _checkAllInputValid(emit);
  }
}

extension on MenuBloc {
  bool _isValidChangePasswordConfirm(String passwordConfirm) {
    return passwordConfirm == state.passwordState.password.value;
  }

  void _onChangePasswordConfirm(
    ChangePasswordConfirm event,
    Emitter<MenuState> emit,
  ) {
    final passwordConfirm = event.passwordConfirm;
    final isValid = _isValidChangePasswordConfirm(passwordConfirm);
    var status = isValid ? FormStatus.complete : FormStatus.inComplete;
    if (passwordConfirm.isEmpty) {
      status = FormStatus.init;
    }
    final passwordConfirmState = state.passwordConfirmState.copyWith(
      passwordConfirm: passwordConfirm,
      status: status,
    );

    emit(
      state.copyWith(
        passwordConfirmState: passwordConfirmState,
      ),
    );

    _checkAllInputValid(emit);
  }
}

extension on MenuBloc {
  void _checkAllInputValid(
    Emitter<MenuState> emit,
  ) {
    final isInputValid = (state.passwordState.status == FormStatus.complete) &&
        (state.passwordConfirmState.status == FormStatus.complete);
    emit(state.copyWith(isInputValid: isInputValid));
  }
}

extension on MenuBloc {
  Future<void> _onPressChangePasswordButton(
    PressChangePasswordButton event,
    Emitter<MenuState> emit,
  ) async {
    _loadingDelegate.set();

    String email = '';
    try {
      email = await _secureStorage.read(key: SecureStorageKey.email);
    } catch (e) {
      log(e.toString());
      return;
    }

    if (email.isEmpty) {
      return;
    }

    final password = state.passwordState.password.value;
    final result = await _ebAuthRepository.changePassword(
      email: email,
      password: password,
    );

    _loadingDelegate.dismiss();

    switch (result) {
      case (SuccessResponse()):
        add(SetChangePasswordStatus(status: BaseStatus.success));
      case (FailureResponse()):
        add(SetChangePasswordStatus(status: BaseStatus.fail));
    }
  }
}

extension on MenuBloc {
  void _onSetChangePasswordStatus(
    SetChangePasswordStatus event,
    Emitter<MenuState> emit,
  ) {
    emit(
      state.copyWith(
        changePasswordStatus: event.status,
      ),
    );
  }
}
