part of '../../../selectroute_view.dart';

class _ListItemRouteInfo extends StatelessWidget {
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

  Expanded _routeTimeTrasport() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '1시간 30분',
            style: TextStyle(
              fontFamily: NanumSquare.extraBold,
              color: EBColors.text,
              fontSize: 26,
            ),
          ),
          const SizedBox(width: 15),
          const Text(
            '지하철 + 버스',
            style: TextStyle(
              fontFamily: NanumSquare.extraBold,
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Expanded _routeSpecificInfo() {
    return const Expanded(
      child: DefaultTextStyle(
        style: TextStyle(
          fontFamily: NanumSquare.bold,
          color: Colors.black54,
          fontSize: 17,
        ),
        child: Row(
          children: [
            Text('환승 1회'),
            SizedBox(width: 20),
            Text('도보 9분'),
            SizedBox(width: 20),
            Text('1200원'),
          ],
        ),
      ),
    );
  }
}
