part of '../../../../../../eb_home.dart';

final class _LeftDispatchPopupButton extends StatelessWidget {
  final Transport? selectedTransport;
  final EBSubPath<Transport> transportSubPath;
  final TransportMap transportMap;
  final List<RealTimeInfo>? realTimeInfoList;
  final int expectTotalMinute;
  final int myIndex;

  const _LeftDispatchPopupButton({
    super.key,
    this.selectedTransport,
    required this.transportSubPath,
    required this.transportMap,
    required this.expectTotalMinute,
    this.realTimeInfoList,
    required this.myIndex,
  });

  @override
  Widget build(BuildContext context) {
    return TransportPopupButton(
      selectedTransport: selectedTransport,
      transportMap: transportMap,
      realTimeInfoList: realTimeInfoList,
      popupButtonContent: _popupButtonContent,
      selectAction: _selectAction(context),
    );
  }

  Function(Transport) _selectAction(BuildContext context) {
    return (Transport selectedItem) {
      context.read<MiddleTranportBloc>().add(
            SelectTransport(
              selectedTransport: selectedItem,
              selectedIndex: myIndex,
            ),
          );
    };
  }

  Widget get _popupButtonContent {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: _LeftDispatchColumnContent(
        selectedTransport: selectedTransport,
        transportSubPath: transportSubPath,
        expectTotalMinute: expectTotalMinute,
      ),
    );
  }
}
