part of '../eb_home_feature.dart';

final class HomeState extends Equatable {
  final BaseStatus loginStatus;

  const HomeState({
    BaseStatus? loginStatus,
  }) : loginStatus = loginStatus ?? BaseStatus.init;

  HomeState copyWith({
    BaseStatus? loginStatus,
  }) =>
      HomeState(
        loginStatus: loginStatus ?? this.loginStatus,
      );

  @override
  List<Object?> get props => [
        loginStatus,
      ];
}
