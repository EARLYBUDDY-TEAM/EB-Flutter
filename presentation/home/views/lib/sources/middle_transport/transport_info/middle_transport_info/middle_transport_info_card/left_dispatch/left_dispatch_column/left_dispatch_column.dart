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

    final content = (transportList is BusList)
        ? _LeftDispatchPopupButtonBus(
            selectedTransport: selectedTransport,
            busList: transportList.busList,
            transportSubPath: transportSubPath,
            expectTotalMinute: expectTotalMinute,
            index: index,
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
}
