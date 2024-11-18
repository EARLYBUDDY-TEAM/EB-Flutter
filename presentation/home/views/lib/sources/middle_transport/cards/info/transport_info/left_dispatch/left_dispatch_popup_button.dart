part of '../../../../../../eb_home.dart';

final class _LeftDispatchPopupButton extends StatefulWidget {
  final Transport? selectedTransport;
  final EBSubPath<Transport> transportSubPath;
  final Map<String, Transport> transportMap;
  final int expectTotalMinute;
  final List<RealTimeInfo>? realTimeInfoList;
  final int myIndex;

  const _LeftDispatchPopupButton({
    super.key,
    required this.selectedTransport,
    required this.transportMap,
    required this.transportSubPath,
    required this.myIndex,
    required this.expectTotalMinute,
    required this.realTimeInfoList,
  });

  @override
  State<StatefulWidget> createState() => _LeftDispatchPopupButtonState();
}

final class _LeftDispatchPopupButtonState
    extends State<_LeftDispatchPopupButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      child: _popupMenuButton(context),
    );
  }

  Widget _popupMenuButton(BuildContext context) {
    return PopupMenuButton<Transport>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.black87,
      color: Colors.white,
      constraints: const BoxConstraints(maxHeight: 300),
      tooltip: "",
      itemBuilder: _itemBuilder(context),
      child: Padding(
        padding: const EdgeInsets.all(8),
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
                selectedIndex: widget.myIndex,
              ),
            );
      },
    );
  }

  PopupMenuItem<Transport> makeMenuItem(Transport transport) {
    String text;
    switch (transport) {
      case Subway():
        text = transport.type;
      case Bus():
        text = transport.number;
    }
    return PopupMenuItem(child: Text(text));
  }

  List<PopupMenuEntry<Transport>> Function(BuildContext context) _itemBuilder(
    BuildContext context,
  ) {
    return (context) {
      final realTimeInfoList = widget.realTimeInfoList;
      if (realTimeInfoList == null) {
        return [];
      }

      List<PopupMenuEntry<Transport>> selectedTransportItem = [];

      List<PopupMenuEntry<Transport>> menuItemList =
          realTimeInfoList.expand<PopupMenuEntry<Transport>>(
        (r) {
          final value = widget.transportMap[r.transportName];
          if (value == null) {
            return [];
          }

          Widget child;

          switch (value) {
            case Subway():
              child = _TransportPopupMenuItemContent.subway(
                subway: value,
                realTimeInfo: r,
              );
            case Bus():
              child = _TransportPopupMenuItemContent.bus(
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

          final selectedTransport = widget.selectedTransport;
          if ((selectedTransport != null) && (selectedTransport == value)) {
            selectedTransportItem = item;
            return [];
          }

          return item;
        },
      ).toList();

      menuItemList = selectedTransportItem + menuItemList;

      if (menuItemList.isNotEmpty) {
        menuItemList.removeLast();
      }

      return menuItemList;
    };
  }
}
