part of '../../../home_feature.dart';

final class HomeStatus extends Equatable {
  final bool login;
  final bool register;
  final BaseStatus getAllScheduleCard;
  final BaseStatus deleteScheduleCard;

  const HomeStatus({
    this.login = false,
    this.register = false,
    BaseStatus? getAllScheduleCard,
    BaseStatus? deleteScheduleCard,
  })  : getAllScheduleCard = getAllScheduleCard ?? BaseStatus.init,
        deleteScheduleCard = deleteScheduleCard ?? BaseStatus.init;

  @override
  List<Object?> get props => [
        login,
        register,
        getAllScheduleCard,
        deleteScheduleCard,
      ];

  HomeStatus copyWith({
    bool? login,
    bool? register,
    BaseStatus? getAllScheduleCard,
    BaseStatus? deleteScheduleCard,
  }) =>
      HomeStatus(
        login: login ?? this.login,
        register: register ?? this.register,
        getAllScheduleCard: getAllScheduleCard ?? this.getAllScheduleCard,
        deleteScheduleCard: deleteScheduleCard ?? this.deleteScheduleCard,
      );
}
