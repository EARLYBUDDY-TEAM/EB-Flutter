part of '../../eb_event.dart';

final class RealTimeInfoEvent {
  final HomeRepositoryAB _homeRepository;
  final SubwayScheduleProvider _subwayScheduleProvider;

  BehaviorSubject<EBSubPath>? _realTimeInfoSubject;
  StreamSubscription<dynamic>? _timerSubscription;

  RealTimeInfoEvent({
    required HomeRepositoryAB homeRepositoryAB,
    SubwayScheduleProvider? subwayScheduleProvider,
  })  : _homeRepository = homeRepositoryAB,
        _subwayScheduleProvider =
            subwayScheduleProvider ?? SubwayScheduleProvider();

  void reloadRealTimeInfo({
    required EBSubPath subPath,
  }) {
    if (_realTimeInfoSubject != null) {
      _realTimeInfoSubject!.add(subPath);
    }
  }

  Future<StreamRealTimeInfo?> makeStreamRealTimeInfo({
    required EBSubPath subPath,
  }) async {
    await _tearDownStream();

    final newRealTimeInfoSubject = BehaviorSubject<EBSubPath>.seeded(subPath);
    _realTimeInfoSubject = newRealTimeInfoSubject;

    final streamRealtimeInfo = _realTimeInfoSubject!.flatMap(
      (subPath) async* {
        final fetchedRealTimeInfoList =
            await _getRealTimeInfo(subPath: subPath);
        yield fetchedRealTimeInfoList;
      },
    );

    _timerSubscription =
        Stream.periodic(const Duration(seconds: 15)).listen((_) {
      if (_realTimeInfoSubject != null) {
        _realTimeInfoSubject!.add(subPath);
      }
    });

    return streamRealtimeInfo;
  }
}

extension on RealTimeInfoEvent {
  Future<void> _tearDownStream() async {
    await _realTimeInfoSubject?.close().then((_) {
      _realTimeInfoSubject = null;
    });

    await _timerSubscription?.cancel().then((_) {
      _timerSubscription = null;
    });
  }
}

extension on RealTimeInfoEvent {
  Future<List<RealTimeInfo>> _getRealTimeInfo({
    required EBSubPath subPath,
  }) async {
    final stationID = subPath.startStationID;
    if (stationID == null) {
      return [];
    }

    final type = subPath.type;
    List<RealTimeInfo> realTimeInfoList;
    switch (type) {
      case 1:
        final wayCode = subPath.wayCode;
        if (wayCode == null) {
          return [];
        }

        final tmpSubway = subPath.transportList.firstOrNull;
        final subway = castOrNull<Subway>(tmpSubway);

        realTimeInfoList = await _getSubwayRealTimeInfo(
          subway: subway,
          stationID: stationID,
          wayCode: wayCode,
        );
      case 2:
        realTimeInfoList = await _getBusRealTimeInfo(
          stationID: stationID,
        );
      default:
        return [];
    }

    return realTimeInfoList;
  }
}

extension on RealTimeInfoEvent {
  Future<List<RealTimeInfo>> _getSubwayRealTimeInfo({
    required Subway? subway,
    required int stationID,
    required int wayCode,
  }) async {
    final key = RequestInfoSubwaySchedule(
      stationID: stationID,
      wayCode: wayCode,
    );

    if (!_subwayScheduleProvider.isExistData(key: key)) {
      final value = await _getTotalSubwaySchedule(
        stationID: stationID,
        wayCode: wayCode,
      );

      if (value == null) {
        return [];
      }

      _subwayScheduleProvider.create(
        key: key,
        value: value,
      );
    }

    final totalSubwaySchedule = _subwayScheduleProvider.read(key: key);
    if (totalSubwaySchedule == null) {
      return [];
    }

    final subwayScheduleList = selectSubwayScheduleList(totalSubwaySchedule);

    final arrivalSecList =
        getArrivalSecFromSubwayScheduleList(subwayScheduleList);

    final arrivalSec1 = arrivalSecList.firstOrNull;
    final arrivalSec2 =
        (arrivalSecList.length == 2) ? arrivalSecList.last : null;
    final transportName = subway?.type ?? "-";

    final subwayRealTimeInfo = RealTimeInfo(
      transportName: transportName,
      arrivalSec1: arrivalSec1,
      leftStation1: null,
      arrivalSec2: arrivalSec2,
      leftStation2: null,
    );

    return [subwayRealTimeInfo];
  }

  Future<TotalSubwaySchedule?> _getTotalSubwaySchedule({
    required int stationID,
    required int wayCode,
  }) async {
    final result = await _homeRepository.getTotalSubwaySchedule(
      stationID: stationID,
      wayCode: wayCode,
    );

    switch (result) {
      case Success():
        final TotalSubwaySchedule totalSubwaySchedule = result.success.model;
        return totalSubwaySchedule;
      case Failure():
        return null;
    }
  }

  List<SubwaySchedule> selectSubwayScheduleList(
    TotalSubwaySchedule totalSubwaySchedule,
  ) {
    final now = DateTime.now();
    final dateName = DateFormat.EEEE().format(now);
    if (dateName == EBDay.Saturday.name) {
      return totalSubwaySchedule.saturDaySchedule;
    } else if (dateName == EBDay.Sunday.name) {
      return totalSubwaySchedule.holidayDaySchedule;
    } else {
      return totalSubwaySchedule.weekDaySchedule;
    }
  }

  List<int> getArrivalSecFromSubwayScheduleList(
    List<SubwaySchedule> subwayScheduleList,
  ) {
    final List<int> arrivalSecList = [];

    for (var subwaySchedule in subwayScheduleList) {
      final leftNow = TimeOfDay.now();
      final rightDepartureTime = subwaySchedule.departureTime;
      final compareResult = leftNow.compareTo(rightDepartureTime);

      if (compareResult == CompareDateResult.left) {
        continue;
      }

      final distMinute = rightDepartureTime.toInt() - leftNow.toInt();
      arrivalSecList.add(distMinute * 60);

      if (2 == arrivalSecList.length) {
        break;
      }
    }

    return arrivalSecList;
  }
}

extension on RealTimeInfoEvent {
  Future<List<RealTimeInfo>> _getBusRealTimeInfo({
    required int stationID,
  }) async {
    final result =
        await _homeRepository.getBusRealTimeInfo(stationID: stationID);
    switch (result) {
      case Success():
        final List<RealTimeInfo> realTimeInfo = result.success.model;
        return realTimeInfo;
      case Failure():
        return [];
    }
  }
}
