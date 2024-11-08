part of '../../../../../../../eb_home.dart';

final class _LeftDispatchColumn extends StatelessWidget {
  final Transport? selectedTransport;
  final EBSubPath transportSubPath;
  final int expectTotalMinute;
  final int index;

  const _LeftDispatchColumn({
    super.key,
    required this.transportSubPath,
    required this.selectedTransport,
    required this.expectTotalMinute,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final transportList = transportSubPath.transportList;

    switch (transportList) {
      case SubwayList():
        return const Text("subway");
      case BusList():
        final busList = transportList.busList;
        if (busList.isEmpty) {
          break;
        }
        return _LeftDispatchPopupButtonBus(
          selectedTransport: selectedTransport,
          busList: transportList.busList,
          transportSubPath: transportSubPath,
          expectTotalMinute: expectTotalMinute,
          index: index,
        );
      default:
        break;
    }
    return _LeftDispatchColumnContent(
      selectedTransport: selectedTransport,
      transportSubPath: transportSubPath,
      expectTotalMinute: expectTotalMinute,
    );
  }
}
