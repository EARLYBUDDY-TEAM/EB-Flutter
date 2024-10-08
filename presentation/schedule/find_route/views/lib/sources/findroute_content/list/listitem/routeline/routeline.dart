part of '../../../../../eb_find_route.dart';

class _RouteLine extends StatelessWidget {
  final TransportLineOfPath lineOfPath;
  final int pathTime;
  final double height = 2;

  const _RouteLine({
    super.key,
    required this.lineOfPath,
    required this.pathTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 35, // transport textsize 구해서 적용하기
      ),
      child: HDashLine(
        stackLine: _TransportLine(
          height: height,
          lineOfPath: lineOfPath,
          totalTime: pathTime,
        ),
      ),
    );
  }
}
