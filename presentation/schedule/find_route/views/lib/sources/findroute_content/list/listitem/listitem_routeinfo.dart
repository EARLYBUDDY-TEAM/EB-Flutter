part of '../../../../eb_find_route.dart';

final class _ListItemRouteInfo extends StatelessWidget {
  final EBPath ebPath;

  const _ListItemRouteInfo({
    required this.ebPath,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _routeState(),
          const SizedBox(height: 3),
          _routeTimeTrasport(),
          _routeSpecificInfo(),
        ],
      ),
    );
  }
}

extension on _ListItemRouteInfo {
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

extension on _ListItemRouteInfo {
  Expanded _routeTimeTrasport() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            EBTime.shared.intToString(ebPath.time),
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

extension on _ListItemRouteInfo {
  Expanded _routeSpecificInfo() {
    final transitCount = ebPath.busTransitCount + ebPath.subwayTransitCount;
    final payment = ebPath.payment;
    final walkTime = EBTime.shared.intToString(ebPath.walkTime);
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
