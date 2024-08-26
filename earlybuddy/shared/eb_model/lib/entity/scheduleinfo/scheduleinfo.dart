part of '../../entity.dart';

final class ScheduleInfo extends Equatable {
  final String title;
  final String? memo;
  final DateTime time;
  final bool isNotify;
  Place? startPlace;
  final Place? endPlace;

  ScheduleInfo({
    String? title,
    this.memo,
    DateTime? time,
    bool? isNotify,
    this.startPlace,
    this.endPlace,
  })  : title = title ?? '',
        time = time ?? DateTime.now(),
        isNotify = isNotify ?? false;

  ScheduleInfo copyWith({
    String? title,
    String? memo,
    DateTime? time,
    bool? isNotify,
    Place? startPlace,
    Place? endPlace,
  }) =>
      ScheduleInfo(
        title: title ?? this.title,
        memo: memo ?? this.memo,
        time: time ?? this.time,
        isNotify: isNotify ?? this.isNotify,
        startPlace: startPlace ?? this.startPlace,
        endPlace: endPlace ?? this.endPlace,
      );

  @override
  List<Object?> get props => [
        title,
        memo,
        time,
        isNotify,
        startPlace,
        endPlace,
      ];

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "memo": memo,
      "time": time.toIso8601String(),
      "isNotify": isNotify,
      "startPlace": startPlace?.toMap(),
      "endPlace": endPlace?.toMap(),
    };
  }
}
