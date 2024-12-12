part of '../eb_menu_feature.dart';

final class MenuViewStatus extends Equatable {
  final BaseStatus changePasswordStatus;
  final BaseStatus removeUserStatus;

  const MenuViewStatus({
    this.changePasswordStatus = BaseStatus.init,
    this.removeUserStatus = BaseStatus.init,
  });

  MenuViewStatus copyWith({
    BaseStatus? changePasswordStatus,
    BaseStatus? removeUserStatus,
  }) {
    return MenuViewStatus(
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
      removeUserStatus: removeUserStatus ?? this.removeUserStatus,
    );
  }

  @override
  List<Object?> get props => [
        changePasswordStatus,
        removeUserStatus,
      ];
}

final class MenuState extends Equatable {
  final bool isInputValid;
  final _PasswordState passwordState;
  final _PasswordConfirmState passwordConfirmState;
  final MenuViewStatus menuViewStatus;

  const MenuState({
    this.isInputValid = false,
    this.passwordState = const _PasswordState(),
    this.passwordConfirmState = const _PasswordConfirmState(),
    this.menuViewStatus = const MenuViewStatus(),
  });

  MenuState copyWith({
    bool? isInputValid,
    _PasswordState? passwordState,
    _PasswordConfirmState? passwordConfirmState,
    MenuViewStatus? menuViewStatus,
  }) {
    return MenuState(
      isInputValid: isInputValid ?? this.isInputValid,
      passwordState: passwordState ?? this.passwordState,
      passwordConfirmState: passwordConfirmState ?? this.passwordConfirmState,
      menuViewStatus: menuViewStatus ?? this.menuViewStatus,
    );
  }

  @override
  List<Object?> get props => [
        isInputValid,
        passwordState,
        passwordConfirmState,
        menuViewStatus,
      ];
}

final class _PasswordState extends Equatable {
  final FormStatus status;
  final Password password;

  const _PasswordState({
    this.status = FormStatus.init,
    this.password = const Password(),
  });

  _PasswordState copyWith({
    FormStatus? status,
    Password? password,
  }) {
    return _PasswordState(
      status: status ?? this.status,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [status, password];
}

final class _PasswordConfirmState extends Equatable {
  final FormStatus status;
  final String passwordConfirm;

  const _PasswordConfirmState({
    this.status = FormStatus.init,
    this.passwordConfirm = '',
  });

  _PasswordConfirmState copyWith({
    FormStatus? status,
    String? passwordConfirm,
  }) {
    return _PasswordConfirmState(
      status: status ?? this.status,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
    );
  }

  @override
  List<Object?> get props => [status, passwordConfirm];
}
