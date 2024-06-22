part of '../../../selectroute_view.dart';

class _ListItemRouteLine extends StatelessWidget {
  final double height = 2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DashLineWithDot(height: height),
    );
  }
}

final class DashLineWithDot extends StatelessWidget {
  final double height;
  final double dotSize = 15;

  const DashLineWithDot({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        DashLine(
          height: height,
          dotSize: dotSize,
        ),
        Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: [
            circleDot(),
            circleDot(),
          ],
        ),
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

final class DashLine extends StatelessWidget {
  final double height;
  final double dotSize;

  const DashLine({
    super.key,
    required this.height,
    required this.dotSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dotSize),
      child: LayoutBuilder(
        builder: ((context, constraints) {
          final boxWidth = constraints.constrainWidth();
          const double dashWidth = 10;
          final dashHeight = height;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(
              dashCount,
              (index) => SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
