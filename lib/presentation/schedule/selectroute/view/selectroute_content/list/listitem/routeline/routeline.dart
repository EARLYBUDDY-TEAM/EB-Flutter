part of '../../../../selectroute_view.dart';

class _RouteLine extends StatelessWidget {
  final double height = 2;
  final double dotSize = 15;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 35, // transport textsize 구해서 적용하기
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          circlePoints(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dotSize),
            child: Stack(
              alignment: Alignment.center,
              children: [
                _DashLine(height: height),
                _TransportLine(height: height),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension on _RouteLine {
  Flex circlePoints() {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: Axis.horizontal,
      children: [
        circleDot(),
        circleDot(),
      ],
    );
  }

  Icon circleDot() {
    return Icon(
      Icons.trip_origin,
      size: dotSize,
      color: Colors.grey,
    );
  }
}
