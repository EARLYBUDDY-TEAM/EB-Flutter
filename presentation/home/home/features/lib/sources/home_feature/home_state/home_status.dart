part of '../../../home_feature.dart';

final class HomeStatus extends Equatable {
  final BaseStatus login;
  final BaseStatus register;
  final BaseStatus getAllScheduleCard;
  final BaseStatus deleteScheduleCard;

  const HomeStatus({
    BaseStatus? login,
    BaseStatus? register,
    BaseStatus? getAllScheduleCard,
    BaseStatus? deleteScheduleCard,
  })  : login = login ?? BaseStatus.init,
        register = register ?? BaseStatus.init,
        getAllScheduleCard = getAllScheduleCard ?? BaseStatus.init,
        deleteScheduleCard = deleteScheduleCard ?? BaseStatus.init;

  @override
  List<Object?> get props => [
        login,
        register,
        getAllScheduleCard,
        deleteScheduleCard,
      ];

  HomeStatus copyWith({
    BaseStatus? login,
    BaseStatus? register,
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
