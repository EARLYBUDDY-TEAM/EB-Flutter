part of '../eb_home_feature.dart';

// final class HomeState extends Equatable {
//   final BaseStatus loginStatus;
//   final BaseStatus registerStatus;
//   final BaseStatus getAllScheduleCardStatus;
//   final List<ScheduleCard> scheduleCardList;

//   HomeState({
//     BaseStatus? loginStatus,
//     BaseStatus? registerStatus,
//     BaseStatus? getAllScheduleCardStatus,
//     List<ScheduleCard>? scheduleCardList,
//   })  : getAllScheduleCardStatus = getAllScheduleCardStatus ?? BaseStatus.init,
//         loginStatus = loginStatus ?? BaseStatus.init,
//         registerStatus = registerStatus ?? BaseStatus.init,
//         scheduleCardList = scheduleCardList ?? [];

//   HomeState copyWith({
//     BaseStatus? loginStatus,
//     BaseStatus? registerStatus,
//     BaseStatus? scheduleCardStatus,
//     List<ScheduleCard>? scheduleCardList,
//   }) =>
//       HomeState(
//         getAllScheduleCardStatus:
//             scheduleCardStatus ?? getAllScheduleCardStatus,
//         loginStatus: loginStatus ?? this.loginStatus,
//         registerStatus: registerStatus ?? this.registerStatus,
//         scheduleCardList: scheduleCardList ?? this.scheduleCardList,
//       );

//   @override
//   List<Object?> get props => [
//         loginStatus,
//         registerStatus,
//         getAllScheduleCardStatus,
//         scheduleCardList,
//       ];
// }

final class HomeState extends Equatable {
  final HomeStatus status;
  final List<ScheduleCard> scheduleCardList;

  HomeState({
    HomeStatus? status,
    List<ScheduleCard>? scheduleCardList,
  })  : status = status ?? const HomeStatus(),
        scheduleCardList = scheduleCardList ?? [];

  @override
  List<Object?> get props => [
        status,
        scheduleCardList,
      ];

  HomeState copyWith({
    HomeStatus? status,
    List<ScheduleCard>? scheduleCardList,
  }) =>
      HomeState(
        status: status ?? this.status,
        scheduleCardList: scheduleCardList ?? this.scheduleCardList,
      );
}

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
