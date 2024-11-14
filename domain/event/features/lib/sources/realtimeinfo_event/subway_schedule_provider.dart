part of '../../eb_event.dart';

final class RequestInfoSubwaySchedule extends Equatable {
  final int stationID;
  final int wayCode;

  const RequestInfoSubwaySchedule({
    required this.stationID,
    required this.wayCode,
  });

  @override
  List<Object?> get props => [
        stationID,
        wayCode,
      ];
}

typedef SubwayScheduleMap = Map<RequestInfoSubwaySchedule, TotalSubwaySchedule>;

final class SubwayScheduleProvider {
  final SubwayScheduleMap _cache = {};

  bool isExistData({
    required RequestInfoSubwaySchedule key,
  }) {
    return _cache.containsKey(key);
  }

  void create({
    required RequestInfoSubwaySchedule key,
    required TotalSubwaySchedule value,
  }) {
    _cache[key] = value;
  }

  TotalSubwaySchedule? read({
    required RequestInfoSubwaySchedule key,
  }) {
    return _cache[key];
  }

  // TotalSubwaySchedule? read()
}
