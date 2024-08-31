part of '../../../../eb_find_route.dart';

final class FindRouteListItem extends StatelessWidget {
  final EBPath ebPath;
  final TransportLineOfPath lineOfPath;

  const FindRouteListItem({
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
          _RouteLine(lineOfPath: lineOfPath, pathTime: ebPath.time)
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
            _ListItemRouteInfo(ebPath: ebPath),
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
