part of '../../../../../../../eb_home.dart';

final class _LeftDispatchColumn extends StatelessWidget {
  final Transport? selectedTransport;
  final EBSubPath transportSubPath;
  final int expectTotalMinute;
  final int index;
  final List<RealTimeInfo>? realTimeInfoList;

  const _LeftDispatchColumn({
    super.key,
    required this.transportSubPath,
    required this.selectedTransport,
    required this.expectTotalMinute,
    required this.index,
    required this.realTimeInfoList,
  });

  @override
  Widget build(BuildContext context) {
    final transportList = transportSubPath.transportList;
    final busMap = _createBusMap(transportList);

    final content = (busMap != null)
        ? _LeftDispatchPopupButtonBus(
            selectedTransport: selectedTransport,
            busMap: busMap,
            transportSubPath: transportSubPath,
            expectTotalMinute: expectTotalMinute,
            index: index,
            realTimeInfoList: realTimeInfoList,
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10),
            child: _LeftDispatchColumnContent(
              selectedTransport: selectedTransport,
              transportSubPath: transportSubPath,
              expectTotalMinute: expectTotalMinute,
            ),
          );

    return content;
  }

  Map<String, Bus>? _createBusMap(TransportList transportList) {
    final tmpTransportList = transportList;
    if (tmpTransportList is! BusList) {
      return null;
    }

    final busMap = {for (var bus in tmpTransportList.busList) bus.number: bus};
    return busMap;
  }
}
