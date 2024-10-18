part of '../../../../../eb_find_route.dart';

final class SelectRouteListItem extends StatelessWidget {
  final EBPath ebPath;
  final TransportLineOfPath lineOfPath;

  const SelectRouteListItem({
    super.key,
    required this.ebPath,
    required this.lineOfPath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          _listItemRouteInfo(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SelectRouteItemLine(
              lineOfPath: lineOfPath,
              pathTime: ebPath.time,
            ),
          ),
        ],
      ),
    );
  }

  Expanded _listItemRouteInfo() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
        child: Row(
          children: [
            _SelectRouteItemInfo(ebPath: ebPath),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
