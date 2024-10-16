part of '../../entity.dart';

final class Schedule extends Equatable {
  final int? id;
  final String title;
  final String? memo;
  final DateTime time;
  final bool isNotify;
  Place? startPlace;
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
    int? id,
    String? title,
    String? memo,
    DateTime? time,
    bool? isNotify,
    Place? startPlace,
    Place? endPlace,
  }) =>
      Schedule(
        id: id ?? this.id,
        title: title ?? this.title,
        memo: memo ?? this.memo,
        time: time ?? this.time,
        isNotify: isNotify ?? this.isNotify,
        startPlace: startPlace ?? this.startPlace,
        endPlace: endPlace ?? this.endPlace,
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
      "id": null,
      "title": title,
      "memo": memo,
      "time": time.toIso8601String(),
      "isNotify": isNotify,
      "startPlace": startPlace?.toMap(),
      "endPlace": endPlace?.toMap(),
    };
  }

  static Schedule mock({
    DateTime? time,
  }) {
    return Schedule(
      id: 10,
      title: "mockwithPlace",
      memo: "memo",
      time: time ?? DateTime.now(),
      isNotify: false,
      startPlace: Place.mockStart(),
      endPlace: Place.mockEnd(),
    );
  }
}