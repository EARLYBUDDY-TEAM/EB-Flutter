part of '../../../../../../../eb_home.dart';

final class _LeftDispatchPopupButtonBus extends StatefulWidget {
  final Transport? selectedTransport;
  final EBSubPath transportSubPath;
  final List<Bus> busList;
  final int index;
  final int expectTotalMinute;

  const _LeftDispatchPopupButtonBus({
    super.key,
    required this.selectedTransport,
    required this.busList,
    required this.transportSubPath,
    required this.index,
    required this.expectTotalMinute,
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
      final List<PopupMenuEntry<Bus>> menuItemList = [];

      for (int index = 0; index < widget.busList.length; index++) {
        final curBus = widget.busList[index];
        final name = curBus.number;
        final color = curBus.color();

        final PopupMenuEntry<Bus> item = PopupMenuItem(
          value: curBus,
          child: _LeftDisPatchPopupMenuItemContent.bus(
            name: name,
            color: color,
            arrivalSec1: 250,
            arrivalSec2: 980,
            leftStation1: 2,
            leftStation2: 5,
          ),
        );

        menuItemList.add(item);

        final isNotLast = (index != widget.busList.length - 1);
        if (isNotLast) {
          menuItemList.add(const PopupMenuDivider());
        }
      }

      return menuItemList;
    };
  }
}