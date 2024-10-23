part of '../../../../../eb_find_route.dart';

final class _SelectRouteItemInfo extends StatelessWidget {
  final bool isBestRoute;
  final EBPath ebPath;

  const _SelectRouteItemInfo({
    required this.ebPath,
    required this.isBestRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _children,
      ),
    );
  }

  List<Widget> get _children {
    return isBestRoute
        ? [
            _routeState(),
            const SizedBox(height: 3),
            _routeTimeTrasport(),
            _routeSpecificInfo(),
          ]
        : [
            const SizedBox(height: 3),
            _routeTimeTrasport(),
            _routeSpecificInfo(),
          ];
  }
}

extension on _SelectRouteItemInfo {
  Expanded _routeState() {
    return Expanded(
      child: Text(
        '최적',
        style: TextStyle(
          fontFamily: FontFamily.nanumSquareExtraBold,
          color: EBColors.blue1,
          fontSize: 18,
        ),
      ),
    );
  }
}

extension on _SelectRouteItemInfo {
  Expanded _routeTimeTrasport() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            EBTime.intToString(ebPath.time),
            style: TextStyle(
              fontFamily: FontFamily.nanumSquareExtraBold,
              color: EBColors.text,
              fontSize: 26,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            _pathType(ebPath.type),
            style: const TextStyle(
              fontFamily: FontFamily.nanumSquareExtraBold,
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  String _pathType(int pathType) {
    if (pathType == 1) {
      return '지하철';
    } else if (pathType == 2) {
      return '버스';
    } else {
      return '지하철 + 버스';
    }
  }
}

extension on _SelectRouteItemInfo {
  Expanded _routeSpecificInfo() {
    final transitCount = ebPath.busTransitCount + ebPath.subwayTransitCount - 1;
    final payment = ebPath.payment;
    final walkTime = EBTime.intToString(ebPath.walkTime);
    return Expanded(
      child: DefaultTextStyle(
        style: const TextStyle(
          fontFamily: FontFamily.nanumSquareBold,
          color: Colors.black54,
          fontSize: 17,
        ),
        child: Row(
          children: [
            Text('환승 $transitCount회'),
            const SizedBox(width: 20),
            Text(walkTime),
            const SizedBox(width: 20),
            Text('$payment원'),
          ],
        ),
      ),
    );
  }
}
