part of '../../entity.dart';

final class ScheduleCard extends Equatable {
  final int scheduleID;
  final String title;
  final DateTime time;
  final String? endPlaceName;

  const ScheduleCard({
    required this.scheduleID,
    required this.title,
    required this.time,
    required this.endPlaceName,
  });

  ScheduleCard.fromDTO({
    required ScheduleCardDTO scheduleCardDTO,
  })  : scheduleID = scheduleCardDTO.scheduleID,
        title = scheduleCardDTO.title,
        time = DateTime.parse(scheduleCardDTO.time),
        endPlaceName = scheduleCardDTO.endPlaceName;

  ScheduleCard copyWith({
    int? scheduleID,
    String? title,
    DateTime? time,
    String? endPlaceName,
  }) =>
      ScheduleCard(
        scheduleID: scheduleID ?? this.scheduleID,
        title: title ?? this.title,
        time: time ?? this.time,
        endPlaceName: endPlaceName ?? this.endPlaceName,
      );

  @override
  List<Object?> get props => [
        scheduleID,
        title,
        time,
        endPlaceName,
      ];

  static ScheduleCard mockwithPlace({
    int? id,
    DateTime? time,
  }) =>
      ScheduleCard(
        scheduleID: id ?? 10,
        title: "MockTitle",
        time: time ?? DateTime.now(),
        endPlaceName: "mockEndPlaceName",
      );

  static ScheduleCard mock({
    int? id,
    DateTime? time,
  }) =>
      ScheduleCard(
        scheduleID: id ?? 10,
        title: "MockTitle",
        time: time ?? DateTime.now(),
        endPlaceName: null,
      );
}
