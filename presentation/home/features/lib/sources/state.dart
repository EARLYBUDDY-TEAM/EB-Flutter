part of '../eb_home_feature.dart';

final class HomeState extends Equatable {
  final BaseStatus loginStatus;
  final BaseStatus registerStatus;

  const HomeState({
    BaseStatus? loginStatus,
    BaseStatus? registerStatus,
  })  : loginStatus = loginStatus ?? BaseStatus.init,
        registerStatus = registerStatus ?? BaseStatus.init;

  HomeState copyWith({
    BaseStatus? loginStatus,
    BaseStatus? registerStatus,
  }) =>
      HomeState(
        loginStatus: loginStatus ?? this.loginStatus,
        registerStatus: registerStatus ?? this.registerStatus,
      );

  @override
  List<Object?> get props => [
        loginStatus,
        registerStatus,
      ];
}
