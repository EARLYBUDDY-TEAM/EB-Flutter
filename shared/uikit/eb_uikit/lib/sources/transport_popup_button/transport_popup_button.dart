part of '../../eb_uikit.dart';

final class TransportPopupButton extends StatelessWidget {
  final Transport? selectedTransport;
  final TransportMap transportMap;
  final List<RealTimeInfo>? realTimeInfoList;
  final Widget popupButtonContent;
  final Function(Transport) selectAction;

  const TransportPopupButton({
    super.key,
    required this.popupButtonContent,
    required this.selectAction,
    required this.transportMap,
    required this.realTimeInfoList,
    required this.selectedTransport,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      child: _popupMenuButton,
    );
  }

  Widget get _popupMenuButton {
    return PopupMenuButton<Transport>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.black87,
      color: Colors.white,
      constraints: const BoxConstraints(maxHeight: 300),
      tooltip: "",
      itemBuilder: _transportPopupMenuItems,
      onSelected: _onSelected,
      child: popupButtonContent,
    );
  }

  void Function(Transport)? get _onSelected {
    return (selectedItem) {
      selectAction(selectedItem);
    };
  }

  List<PopupMenuEntry<Transport>> Function(BuildContext context)
      get _transportPopupMenuItems {
    return (context) {
      if (realTimeInfoList == null) {
        return [];
      }

      List<PopupMenuEntry<Transport>> selectedTransportItem = [];
      List<PopupMenuEntry<Transport>> menuItemList =
          realTimeInfoList!.expand<PopupMenuEntry<Transport>>((r) {
        final value = transportMap[r.transportName];
        if (value == null) {
          return [];
        }

        Widget child;

        switch (value) {
          case Subway():
            child = TransportPopupMenuItemContent.subway(
              subway: value,
              realTimeInfo: r,
            );
          case Bus():
            child = TransportPopupMenuItemContent.bus(
              bus: value,
              realTimeInfo: r,
            );
        }

        final tmpItem = PopupMenuItem(
          value: value,
          child: child,
        );
        final List<PopupMenuEntry<Transport>> item = [
          tmpItem,
          const PopupMenuDivider()
        ];

        if (selectedTransport == value) {
          selectedTransportItem = item;
          return [];
        }

        return item;
      }).toList();

      menuItemList = selectedTransportItem + menuItemList;

      if (menuItemList.isNotEmpty) {
        menuItemList.removeLast();
      }

      return menuItemList;
    };
  }
}
