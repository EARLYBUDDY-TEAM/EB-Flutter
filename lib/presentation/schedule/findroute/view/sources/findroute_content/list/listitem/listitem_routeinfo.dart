part of '../../../findroute_view.dart';

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
          fontFamily: NanumSquare.extraBold,
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
            ebPath.ebPathInfo.totalTime,
            style: TextStyle(
              fontFamily: NanumSquare.extraBold,
              color: EBColors.text,
              fontSize: 26,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            ebPath.pathType,
            style: const TextStyle(
              fontFamily: NanumSquare.extraBold,
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

extension on _ListItemRouteInfo {
  Expanded _routeSpecificInfo() {
    final transitCount = ebPath.ebPathInfo.transitCount;
    final payment = ebPath.ebPathInfo.payment;
    return Expanded(
      child: DefaultTextStyle(
        style: const TextStyle(
          fontFamily: NanumSquare.bold,
          color: Colors.black54,
          fontSize: 17,
        ),
        child: Row(
          children: [
            Text('환승 $transitCount회'),
            const SizedBox(width: 20),
            const Text('도보 9분'),
            const SizedBox(width: 20),
            Text('$payment원'),
          ],
        ),
      ),
    );
  }
}
