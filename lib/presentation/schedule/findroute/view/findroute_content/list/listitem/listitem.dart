part of '../../../findroute_view.dart';

final class FindRouteListItem extends StatelessWidget {
  final EBPath ebPath;
  final TransportLineOfPath lineOfPath;
  final bool isLast;

  const FindRouteListItem({
    super.key,
    required this.ebPath,
    required this.lineOfPath,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    if (isLast) {
      return odsayImage();
    } else {
      return Column(
        children: [
          SizedBox(
            height: 200,
            child: Column(
              children: [
                _listItemRouteInfo(),
                _RouteLine(lineOfPath: lineOfPath, pathTime: ebPath.time)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(color: Colors.grey.withOpacity(0.5)),
          )
        ],
      );
    }
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

  Container odsayImage() {
    return Container(
      height: 100,
      color: Colors.red,
    );
  }
}
