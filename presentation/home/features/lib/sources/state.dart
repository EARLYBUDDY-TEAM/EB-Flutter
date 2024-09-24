part of '../eb_home_feature.dart';

final class HomeState extends Equatable {
  final BaseStatus loginStatus;
  final BaseStatus registerStatus;

  final bool firstTime;

  const HomeState({
    BaseStatus? loginStatus,
    BaseStatus? registerStatus,
    bool? firstTime,
  })  : loginStatus = loginStatus ?? BaseStatus.init,
        registerStatus = registerStatus ?? BaseStatus.init,
        firstTime = firstTime ?? false;

  HomeState copyWith({
    BaseStatus? loginStatus,
    BaseStatus? registerStatus,
    bool? firstTime,
  }) =>
      HomeState(
        loginStatus: loginStatus ?? this.loginStatus,
        registerStatus: registerStatus ?? this.registerStatus,
        firstTime: firstTime ?? this.firstTime,
      );

  @override
  List<Object?> get props => [
        loginStatus,
        registerStatus,
        firstTime,
      ];
}
