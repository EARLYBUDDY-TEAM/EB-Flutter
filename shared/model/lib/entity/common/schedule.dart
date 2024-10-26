part of '../../entity.dart';

final class Schedule extends Equatable {
  final String? id;
  final String title;
  final String? memo;
  final DateTime time;
  final bool isNotify;
  final Place? startPlace;
  final Place? endPlace;

  Schedule({
    this.id,
    String? title,
    this.memo,
    DateTime? time,
    bool? isNotify,
    this.startPlace,
    this.endPlace,
  })  : title = title ?? '',
        time = time ?? DateTime.now(),
        isNotify = isNotify ?? false;

  Schedule copyWith({
    String? Function()? id,
    String? title,
    String? Function()? memo,
    DateTime? time,
    bool? isNotify,
    Place? Function()? startPlace,
    Place? Function()? endPlace,
  }) =>
      Schedule(
        id: id != null ? id() : this.id,
        title: title ?? this.title,
        memo: memo != null ? memo() : this.memo,
        time: time ?? this.time,
        isNotify: isNotify ?? this.isNotify,
        startPlace: startPlace != null ? startPlace() : this.startPlace,
        endPlace: endPlace != null ? endPlace() : this.endPlace,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        memo,
        time,
        isNotify,
        startPlace,
        endPlace,
      ];

  Schedule.fromDTO({
    required ScheduleDTO scheduleDTO,
  })  : id = scheduleDTO.id,
        title = scheduleDTO.title,
        memo = scheduleDTO.memo,
        time = DateTime.parse(scheduleDTO.time),
        isNotify = scheduleDTO.isNotify,
        startPlace = (scheduleDTO.startPlaceDTO != null)
            ? Place.fromDTO(placeDTO: scheduleDTO.startPlaceDTO!)
            : null,
        endPlace = (scheduleDTO.endPlaceDTO != null)
            ? Place.fromDTO(placeDTO: scheduleDTO.endPlaceDTO!)
            : null;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "memo": memo,
      "time": time.toIso8601String(),
      "isNotify": isNotify,
      "startPlaceInfo": (startPlace != null) ? startPlace!.toMap() : null,
      "endPlaceInfo": (endPlace != null) ? endPlace!.toMap() : null,
    };
  }

  static Schedule mock({
    DateTime? time,
  }) {
    return Schedule(
      id: "id",
      title: "mockwithPlace",
      memo: "memo",
      time: time ?? DateTime.now(),
      isNotify: false,
      startPlace: Place.mockStart(),
      endPlace: Place.mockEnd(),
    );
  }
}
