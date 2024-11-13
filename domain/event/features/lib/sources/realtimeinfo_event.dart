part of '../eb_event.dart';

final class RealTimeInfoEvent {
  final HomeRepositoryAB _homeRepository;

  BehaviorSubject<EBSubPath>? _realTimeInfoSubject;
  StreamSubscription<dynamic>? _timerSubscription;

  RealTimeInfoEvent({
    required HomeRepositoryAB homeRepositoryAB,
  }) : _homeRepository = homeRepositoryAB;

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

        realTimeInfoList = await _getSubwayRealTimeInfo(
          stationID: stationID,
          wayCode: wayCode,
        );
      case 2:
        realTimeInfoList = await _getBusRealTimeInfo(stationID: stationID);
      default:
        return [];
    }

    return realTimeInfoList;
  }

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

  Future<List<RealTimeInfo>> _getSubwayRealTimeInfo({
    required int stationID,
    required int wayCode,
  }) async {
    return [];
  }
}
