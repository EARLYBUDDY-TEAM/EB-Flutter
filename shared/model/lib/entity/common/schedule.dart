part of '../../entity.dart';

final class Schedule extends Equatable {
  final String? id;
  final String title;
  final String? memo;
  final DateTime time;
  final int? notifySchedule;
  final int? notifyTransport;
  final int? notifyTransportRange;
  final Place? startPlace;
  final Place? endPlace;

  Schedule({
    this.id,
    String? title,
    this.memo,
    DateTime? time,
    this.notifySchedule,
    this.notifyTransport,
    this.notifyTransportRange,
    this.startPlace,
    this.endPlace,
  })  : title = title ?? '',
        time = time ?? DateTime.now();

  Schedule copyWith({
    String? Function()? id,
    String? title,
    String? Function()? memo,
    DateTime? time,
    int? Function()? notifySchedule,
    int? Function()? notifyTransport,
    int? Function()? notifyTransportRange,
    Place? Function()? startPlace,
    Place? Function()? endPlace,
  }) =>
      Schedule(
        id: id != null ? id() : this.id,
        title: title ?? this.title,
        memo: memo != null ? memo() : this.memo,
        time: time ?? this.time,
        notifySchedule:
            notifySchedule != null ? notifySchedule() : this.notifySchedule,
        notifyTransport:
            notifyTransport != null ? notifyTransport() : this.notifyTransport,
        notifyTransportRange: notifyTransportRange != null
            ? notifyTransportRange()
            : this.notifyTransportRange,
        startPlace: startPlace != null ? startPlace() : this.startPlace,
        endPlace: endPlace != null ? endPlace() : this.endPlace,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        memo,
        time,
        notifySchedule,
        notifyTransport,
        notifyTransportRange,
        startPlace,
        endPlace,
      ];

  Schedule.fromDTO({
    required ScheduleDTO scheduleDTO,
  })  : id = scheduleDTO.id,
        title = scheduleDTO.title,
        memo = scheduleDTO.memo,
        time = DateTime.parse(scheduleDTO.time),
        notifySchedule = scheduleDTO.notifySchedule,
        notifyTransport = scheduleDTO.notifyTransport,
        notifyTransportRange = scheduleDTO.notifyTransportRange,
        startPlace = (scheduleDTO.startPlaceDTO != null)
            ? Place.fromDTO(placeDTO: scheduleDTO.startPlaceDTO!)
            : null,
        endPlace = (scheduleDTO.endPlaceDTO != null)
            ? Place.fromDTO(placeDTO: scheduleDTO.endPlaceDTO!)
            : null;

  ScheduleDTO toDTO() {
    return ScheduleDTO(
      id: id,
      title: title,
      memo: memo,
      time: time.toIso8601String(),
      notifySchedule: notifySchedule,
      notifyTransport: notifyTransport,
      notifyTransportRange: notifyTransportRange,
      startPlaceDTO: startPlace?.toDTO(),
      endPlaceDTO: endPlace?.toDTO(),
    );
  }

  static Schedule mock({
    DateTime? time,
  }) {
    return Schedule(
      id: "id",
      title: "mockwithPlace",
      memo: "memo",
      time: time ?? DateTime.now(),
      notifySchedule: 10,
      notifyTransport: 10,
      notifyTransportRange: 10,
      startPlace: Place.mockStart(),
      endPlace: Place.mockEnd(),
    );
  }
}
