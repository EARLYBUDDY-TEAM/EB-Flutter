part of '../../../../../../eb_home.dart';

final class _LeftDispatchColumn extends StatelessWidget {
  final Transport? selectedTransport;
  final EBSubPath transportSubPath;
  final int expectTotalMinute;
  final int myIndex;
  final List<RealTimeInfo>? realTimeInfoList;

  const _LeftDispatchColumn({
    super.key,
    required this.transportSubPath,
    required this.selectedTransport,
    required this.expectTotalMinute,
    required this.myIndex,
    required this.realTimeInfoList,
  });

  @override
  Widget build(BuildContext context) {
    final transportList = transportSubPath.transportList;
    final transportMap = _createTransportMap(transportList);

    return _LeftDispatchPopupButton(
      selectedTransport: selectedTransport,
      transportMap: transportMap,
      transportSubPath: transportSubPath,
      expectTotalMinute: expectTotalMinute,
      myIndex: myIndex,
      realTimeInfoList: realTimeInfoList,
    );
  }

  Map<String, Transport> _createTransportMap(
    List<Transport> transportList,
  ) {
    Map<String, Transport> tmpTransportMap = {};
    switch (transportList) {
      case List<Subway>():
        tmpTransportMap = {for (var t in transportList) t.type: t};
      case List<Bus>():
        tmpTransportMap = {for (var t in transportList) t.number: t};
    }

    return tmpTransportMap;
  }
}
