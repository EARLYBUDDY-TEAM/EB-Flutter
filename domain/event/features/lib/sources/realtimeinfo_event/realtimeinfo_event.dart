part of '../../eb_event.dart';

final class RealTimeInfoEvent {
  final HomeRepositoryAB _homeRepository;
  final int reloadLoopSec = 15;

  BehaviorSubject<EBSubPath>? _realTimeInfoSubject;
  StreamSubscription<dynamic>? _timerSubscription;

  RealTimeInfoEvent({
    required HomeRepositoryAB homeRepository,
  }) : _homeRepository = homeRepository;

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
        Stream.periodic(Duration(seconds: reloadLoopSec)).listen((_) {
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
        final tmpDirection = subPath.wayCode;
        if ((subway == null) || (tmpDirection == null)) {
          return [];
        }

        final stationName = subPath.startName;
        final lineName = subway.type;
        final direction = (tmpDirection == 1) ? 0 : 1;

        realTimeInfoList = await _getSubwayRealTimeInfo(
          stationName: stationName,
          lineName: lineName,
          direction: direction,
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
  Future<List<RealTimeInfo>> _getBusRealTimeInfo({
    required int stationID,
  }) async {
    final result =
        await _homeRepository.getBusRealTimeInfo(stationID: stationID);
    switch (result) {
      case SuccessResponse():
        final List<RealTimeInfo> realTimeInfo = result.model;
        return realTimeInfo;
      case FailureResponse():
        return [];
    }
  }
}

extension on RealTimeInfoEvent {
  Future<List<RealTimeInfo>> _getSubwayRealTimeInfo({
    required String stationName,
    required String lineName,
    required int direction,
  }) async {
    final result = await _homeRepository.getSubwayRealTimeInfo(
      stationName: stationName,
      lineName: lineName,
      direction: direction,
    );
    switch (result) {
      case SuccessResponse():
        final List<RealTimeInfo> realTimeInfo = result.model;
        return realTimeInfo;
      case FailureResponse():
        return [];
    }
  }
}
