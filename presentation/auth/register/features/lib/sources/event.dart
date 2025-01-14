part of '../eb_register_feature.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

final class ChangeNickName extends RegisterEvent {
  final String nickName;

  const ChangeNickName(this.nickName);

  @override
  List<Object?> get props => [nickName];
}

final class ChangeEmail extends RegisterEvent {
  final String email;

  const ChangeEmail(this.email);

  @override
  List<Object?> get props => [email];
}

final class ChangePassword extends RegisterEvent {
  final String password;

  const ChangePassword(this.password);

  @override
  List<Object?> get props => [password];
}

final class ChangePasswordConfirm extends RegisterEvent {
  final String passwordConfirm;

  const ChangePasswordConfirm(this.passwordConfirm);

  @override
  List<Object?> get props => [passwordConfirm];
}

final class PressRegisterButton extends RegisterEvent {
  const PressRegisterButton();
}

final class PressAlertOkButton extends RegisterEvent {
  const PressAlertOkButton();
}

final class PressRecommendNickNameButton extends RegisterEvent {
  const PressRecommendNickNameButton();
}
