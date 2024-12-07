part of '../eb_menu_feature.dart';

final class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final RootDelegate _rootDelegate;
  final LoginDelegate _loginDelegate;
  final SecureStorage _secureStorage;

  MenuBloc({
    required RootDelegate rootDelegate,
    required LoginDelegate loginDelegate,
    SecureStorage? secureStorage,
  })  : _rootDelegate = rootDelegate,
        _loginDelegate = loginDelegate,
        _secureStorage = secureStorage ?? SecureStorage(),
        super(const MenuState()) {
    on<PressLogoutButton>(_onPressLogoutButton);
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
