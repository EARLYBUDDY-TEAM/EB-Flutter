part of '../eb_home_feature.dart';

final class HomeState extends Equatable {
  final BaseStatus loginStatus;
  final BaseStatus registerStatus;
  final BaseStatus scheduleCardStatus;
  final List<ScheduleCard> scheduleCardList;

  HomeState({
    BaseStatus? loginStatus,
    BaseStatus? registerStatus,
    BaseStatus? scheduleCardStatus,
    List<ScheduleCard>? scheduleCardList,
  })  : scheduleCardStatus = scheduleCardStatus ?? BaseStatus.init,
        loginStatus = loginStatus ?? BaseStatus.init,
        registerStatus = registerStatus ?? BaseStatus.init,
        scheduleCardList = scheduleCardList ?? [];

  HomeState copyWith({
    BaseStatus? loginStatus,
    BaseStatus? registerStatus,
    BaseStatus? scheduleCardStatus,
    List<ScheduleCard>? scheduleCardList,
  }) =>
      HomeState(
        scheduleCardStatus: scheduleCardStatus ?? this.scheduleCardStatus,
        loginStatus: loginStatus ?? this.loginStatus,
        registerStatus: registerStatus ?? this.registerStatus,
        scheduleCardList: scheduleCardList ?? this.scheduleCardList,
      );

  @override
  List<Object?> get props => [
        loginStatus,
        registerStatus,
        scheduleCardStatus,
        scheduleCardList,
      ];
}
