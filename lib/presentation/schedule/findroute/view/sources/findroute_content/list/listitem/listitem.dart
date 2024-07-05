part of '../../../findroute_view.dart';

final class FindRouteListItem extends StatelessWidget {
  final EBPath ebPath;

  const FindRouteListItem({
    super.key,
    required this.ebPath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          _listItemRouteInfo(),
          RouteLine(),
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
