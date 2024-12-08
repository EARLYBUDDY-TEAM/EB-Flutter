part of '../eb_menu_feature.dart';

final class MenuState extends Equatable {
  final bool isInputValid;
  final _PasswordState passwordState;
  final _PasswordConfirmState passwordConfirmState;
  final BaseStatus changePasswordStatus;

  const MenuState({
    this.isInputValid = false,
    this.passwordState = const _PasswordState(),
    this.passwordConfirmState = const _PasswordConfirmState(),
    this.changePasswordStatus = BaseStatus.init,
  });

  MenuState copyWith({
    bool? isInputValid,
    _PasswordState? passwordState,
    _PasswordConfirmState? passwordConfirmState,
    BaseStatus? changePasswordStatus,
  }) {
    return MenuState(
      isInputValid: isInputValid ?? this.isInputValid,
      passwordState: passwordState ?? this.passwordState,
      passwordConfirmState: passwordConfirmState ?? this.passwordConfirmState,
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
    );
  }

  @override
  List<Object?> get props => [
        isInputValid,
        passwordState,
        passwordConfirmState,
        changePasswordStatus,
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
