part of '../../../../../../../eb_home.dart';

final class _LeftDispatchPopupButtonBus extends StatefulWidget {
  final Transport? selectedTransport;
  final EBSubPath transportSubPath;
  final Map<String, Bus> busMap;
  final int index;
  final int expectTotalMinute;
  final List<RealTimeInfo>? realTimeInfoList;

  const _LeftDispatchPopupButtonBus({
    super.key,
    required this.selectedTransport,
    required this.busMap,
    required this.transportSubPath,
    required this.index,
    required this.expectTotalMinute,
    required this.realTimeInfoList,
  });

  @override
  State<StatefulWidget> createState() => _LeftDispatchPopupButtonStateBus();
}

final class _LeftDispatchPopupButtonStateBus
    extends State<_LeftDispatchPopupButtonBus> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      child: _popupMenuButton(context),
    );
  }

  Widget _popupMenuButton(BuildContext context) {
    return PopupMenuButton<Bus>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.black87,
      color: Colors.white,
      constraints: const BoxConstraints(maxHeight: 300),
      tooltip: "",
      itemBuilder: _itemBuilder(context),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: _LeftDispatchColumnContent(
          selectedTransport: widget.selectedTransport,
          transportSubPath: widget.transportSubPath,
          expectTotalMinute: widget.expectTotalMinute,
        ),
      ),
      onSelected: (selectedItem) {
        context.read<MiddleTranportBloc>().add(
              SelectTransport(
                selectedTransport: selectedItem,
                selectedIndex: widget.index,
              ),
            );
      },
    );
  }

  PopupMenuItem<Bus> makeMenuItem(Bus bus) {
    return PopupMenuItem(child: Text(bus.number));
  }

  List<PopupMenuEntry<Bus>> Function(BuildContext context) _itemBuilder(
    BuildContext context,
  ) {
    return (context) {
      final realTimeInfoList = widget.realTimeInfoList;
      if (realTimeInfoList == null) {
        return [];
      }

      final List<PopupMenuEntry<Bus>> menuItemList =
          realTimeInfoList.expand<PopupMenuEntry<Bus>>(
        (r) {
          final curBus = widget.busMap[r.transportName];
          if (curBus == null) {
            return [];
          }

          final PopupMenuEntry<Bus> item = PopupMenuItem(
            value: curBus,
            child: _LeftDisPatchPopupMenuItemContent.bus(
              bus: curBus,
              realTimeInfo: r,
            ),
          );

          return [item, const PopupMenuDivider()];
        },
      ).toList();

      if (menuItemList.isNotEmpty) {
        menuItemList.removeLast();
      }

      return menuItemList;
    };
  }
}
