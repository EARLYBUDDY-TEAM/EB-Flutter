part of '../eb_menu_feature.dart';

final class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final LoadingDelegate _loadingDelegate;
  final RootDelegate _rootDelegate;
  final LoginDelegate _loginDelegate;
  final EBAuthRepository _ebAuthRepository;
  final EBTokenEvent _tokenEvent;
  final NotiStatusRepository _notiStatusRepository;
  final SecureStorage _secureStorage;
  Future<String?> get getUserEmail async {
    try {
      return await _secureStorage.read(key: SecureStorageKey.email);
    } catch (e) {
      return null;
    }
  }

  MenuBloc({
    required LoadingDelegate loadingDelegate,
    required RootDelegate rootDelegate,
    required LoginDelegate loginDelegate,
    required EBAuthRepository ebAuthRepository,
    required EBTokenEvent tokenEvent,
    required NotiStatusRepository notiStatusRepository,
    SecureStorage? secureStorage,
  })  : _loadingDelegate = loadingDelegate,
        _rootDelegate = rootDelegate,
        _loginDelegate = loginDelegate,
        _ebAuthRepository = ebAuthRepository,
        _tokenEvent = tokenEvent,
        _secureStorage = secureStorage ?? SecureStorage.shared,
        _notiStatusRepository = notiStatusRepository,
        super(const MenuState()) {
    on<PressLogoutButton>(_onPressLogoutButton);
    on<ChangePassword>(_onChangePassword);
    on<ChangePasswordConfirm>(_onChangePasswordConfirm);
    on<PressChangePasswordButton>(_onPressChangePasswordButton);
    on<SetMenuViewStatus>(_onSetChangePasswordStatus);
    on<PressRemoveUserButton>(_onPressRemoveUserButton);
    on<SetUnAuthenticated>(_onSetUnAuthenticated);
    on<ToggleNotificationSwitch>(_onToggleNotificationSwitch);
    on<SetupHomeMenuListView>(_onSetupHomeMenuListView);
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
    final passwordState = state.changePasswordState.passwordState.copyWith(
      password: password,
      status: status,
    );
    final changePasswordState = state.changePasswordState.copyWith(
      passwordState: passwordState,
    );
    emit(
      state.copyWith(
        changePasswordState: changePasswordState,
      ),
    );

    final passwordConfirm =
        state.changePasswordState.passwordConfirmState.passwordConfirm;
    add(ChangePasswordConfirm(passwordConfirm: passwordConfirm));

    _checkAllInputValid(emit);
  }
}

extension on MenuBloc {
  bool _isValidChangePasswordConfirm(String passwordConfirm) {
    return passwordConfirm ==
        state.changePasswordState.passwordState.password.value;
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
    final passwordConfirmState =
        state.changePasswordState.passwordConfirmState.copyWith(
      passwordConfirm: passwordConfirm,
      status: status,
    );
    final changePasswordState = state.changePasswordState.copyWith(
      passwordConfirmState: passwordConfirmState,
    );

    emit(
      state.copyWith(
        changePasswordState: changePasswordState,
      ),
    );

    _checkAllInputValid(emit);
  }
}

extension on MenuBloc {
  void _checkAllInputValid(
    Emitter<MenuState> emit,
  ) {
    final isInputValid = (state.changePasswordState.passwordState.status ==
            FormStatus.complete) &&
        (state.changePasswordState.passwordConfirmState.status ==
            FormStatus.complete);
    final changePasswordState = state.changePasswordState.copyWith(
      isInputValid: isInputValid,
    );
    emit(state.copyWith(changePasswordState: changePasswordState));
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

    final password = state.changePasswordState.passwordState.password.value;
    final result = await _ebAuthRepository.changePassword(
      email: email,
      password: password,
    );

    _loadingDelegate.dismiss();

    switch (result) {
      case (SuccessResponse()):
        add(
          SetMenuViewStatus(
            changePasswordStatus: BaseStatus.success,
          ),
        );
      case (FailureResponse()):
        add(
          SetMenuViewStatus(
            changePasswordStatus: BaseStatus.fail,
          ),
        );
    }
  }
}

extension on MenuBloc {
  void _onSetChangePasswordStatus(
    SetMenuViewStatus event,
    Emitter<MenuState> emit,
  ) {
    final menuViewStatus = state.menuViewStatus.copyWith(
      changePasswordStatus: event.changePasswordStatus,
      removeUserStatus: event.removeUserStatus,
    );

    emit(
      state.copyWith(
        menuViewStatus: menuViewStatus,
      ),
    );
  }
}

extension on MenuBloc {
  Future<void> _onPressRemoveUserButton(
    PressRemoveUserButton event,
    Emitter<MenuState> emit,
  ) async {
    _loadingDelegate.set();

    Future<NetworkResponse<EmptyDTO>> removeUserEvent(
      String accessToken,
    ) async {
      return await _ebAuthRepository.removeUser(
        accessToken: accessToken,
      );
    }

    final NetworkResponse<EmptyDTO> removeUserResult =
        await _tokenEvent.checkExpired(withEvent: removeUserEvent);

    _loadingDelegate.dismiss();

    switch (removeUserResult) {
      case SuccessResponse():
        add(
          SetMenuViewStatus(
            removeUserStatus: BaseStatus.success,
          ),
        );
      case FailureResponse():
        add(
          SetMenuViewStatus(
            removeUserStatus: BaseStatus.fail,
          ),
        );
    }
  }
}

extension on MenuBloc {
  Future<void> _onSetUnAuthenticated(
    SetUnAuthenticated event,
    Emitter<MenuState> emit,
  ) async {
    final List<SecureStorageKey> keysToEliminate = [
      SecureStorageKey.accessToken,
      SecureStorageKey.refreshToken,
      SecureStorageKey.isAutoLogin,
      SecureStorageKey.email,
      SecureStorageKey.password,
    ];

    for (final key in keysToEliminate) {
      try {
        await _secureStorage.delete(key: key);
      } catch (e) {
        log(e.toString());
      }
    }

    _rootDelegate.authStatus.add(UnAuthenticated());
  }
}

extension on MenuBloc {
  Future<void> _onToggleNotificationSwitch(
    ToggleNotificationSwitch event,
    Emitter<MenuState> emit,
  ) async {
    final curNotiStatus = state.notificationStatus;

    emit(state.copyWith(notificationStatus: NotificationStatus.checking));
    NetworkResponse<EmptyDTO> result;
    final userEmail = await getUserEmail;
    if (userEmail == null) {
      emit(state.copyWith(notificationStatus: NotificationStatus.disabled));
      return;
    }

    switch (curNotiStatus) {
      case NotificationStatus.enabled:
        result = await _notiStatusRepository.disable(
          userEmail: userEmail,
        );
      case NotificationStatus.disabled:
        final fcmToken = await NotificationManager.getFCMToken();
        if (fcmToken == null) {
          emit(state.copyWith(notificationStatus: NotificationStatus.disabled));
          return;
        }

        result = await _notiStatusRepository.enable(
          userEmail: userEmail,
          fcmToken: fcmToken,
        );
      case NotificationStatus.checking:
        emit(state.copyWith(notificationStatus: NotificationStatus.disabled));
        return;
    }

    switch (curNotiStatus) {
      case NotificationStatus.enabled:
        switch (result) {
          case SuccessResponse():
            emit(
              state.copyWith(
                notificationStatus: NotificationStatus.disabled,
              ),
            );
          case FailureResponse():
            emit(
              state.copyWith(
                notificationStatus: NotificationStatus.disabled,
              ),
            );
        }
      case NotificationStatus.disabled:
        switch (result) {
          case SuccessResponse():
            emit(
              state.copyWith(
                notificationStatus: NotificationStatus.enabled,
              ),
            );
          case FailureResponse():
            emit(
              state.copyWith(
                notificationStatus: NotificationStatus.disabled,
              ),
            );
        }
      case NotificationStatus.checking:
        emit(
          state.copyWith(
            notificationStatus: NotificationStatus.disabled,
          ),
        );
    }
  }
}

extension on MenuBloc {
  Future<void> _onSetupHomeMenuListView(
    SetupHomeMenuListView event,
    Emitter<MenuState> emit,
  ) async {
    final userEmail = await getUserEmail;
    if (userEmail == null) {
      emit(state.copyWith(notificationStatus: NotificationStatus.disabled));
      return;
    }
    final result = await _notiStatusRepository.get(userEmail: userEmail);

    switch (result) {
      case SuccessResponse():
        final isAuthorized = result.model;
        final notificationStatus = isAuthorized
            ? NotificationStatus.enabled
            : NotificationStatus.disabled;

        emit(
          state.copyWith(
            notificationStatus: notificationStatus,
          ),
        );
      case FailureResponse():
        emit(state.copyWith(notificationStatus: NotificationStatus.disabled));
        return;
    }
  }
}
