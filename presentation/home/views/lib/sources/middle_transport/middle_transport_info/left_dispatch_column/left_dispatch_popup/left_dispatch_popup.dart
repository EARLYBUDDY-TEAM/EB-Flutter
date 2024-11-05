part of '../../../../../eb_home.dart';

final class _LeftDispatchPopupButtonBus extends StatefulWidget {
  final EBSubPath transportSubPath;
  final List<Bus> busList;

  const _LeftDispatchPopupButtonBus({
    super.key,
    required this.busList,
    required this.transportSubPath,
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
      child: PopupMenuButton<Bus>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black87,
        color: Colors.white,
        constraints: const BoxConstraints(maxHeight: 300),
        tooltip: "",
        itemBuilder: _itemBuilder(context),
        child: _LeftDispatchColumnContent(
          subPath: widget.transportSubPath,
        ),
      ),
    );
  }

  PopupMenuItem<Bus> makeMenuItem(Bus bus) {
    return PopupMenuItem(child: Text(bus.number));
  }

  List<PopupMenuItem<Bus>> Function(BuildContext context) _itemBuilder(
    BuildContext context,
  ) {
    return (context) => List.generate(
          widget.busList.length,
          (index) {
            final curBus = widget.busList[index];
            final name = curBus.number;
            final color = curBus.color();
            final isLast = (index == widget.busList.length - 1);

            return PopupMenuItem(
              child: _LeftDisPatchPopupMenuItem.bus(
                name: name,
                color: color,
                arrivalSec1: 250,
                arrivalSec2: 980,
                leftStation1: 2,
                leftStation2: 5,
                isLast: isLast,
              ),
            );
          },
        );
  }
}
