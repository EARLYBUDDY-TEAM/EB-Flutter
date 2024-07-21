part of 'eb_sources.dart';

final class HDashLine extends StatelessWidget {
  final StatelessWidget? stackLine;
  final Color color;
  final double dotSize = 15;

  const HDashLine({
    super.key,
    this.color = Colors.grey,
    this.stackLine,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _circlePoints(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: dotSize),
          child: Stack(
            alignment: Alignment.center,
            children: stackChildren(),
          ),
        ),
      ],
    );
  }

  List<Widget> stackChildren() {
    return stackLine != null
        ? [_HDash(color: color), stackLine!]
        : [_HDash(color: color)];
  }

  Row _circlePoints() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _circleDot(),
        _circleDot(),
      ],
    );
  }

  Icon _circleDot() {
    return Icon(
      Icons.trip_origin,
      size: dotSize,
      color: color,
    );
  }
}

final class _HDash extends StatelessWidget {
  final double height;
  final Color color;

  const _HDash({
    this.height = 2,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const double dashWidth = 7;
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
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            ),
          ),
        );
      }),
    );
  }
}

final class VDashLine extends StatelessWidget {
  final StatelessWidget? stackLine;
  final Color color;
  final double dotSize = 15;

  const VDashLine({
    super.key,
    this.stackLine,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _circlePoints(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dotSize),
          child: Stack(
            alignment: Alignment.center,
            children: stackChildren(),
          ),
        ),
      ],
    );
  }

  List<Widget> stackChildren() {
    return stackLine != null
        ? [_VDash(color: color), stackLine!]
        : [_VDash(color: color)];
  }

  Column _circlePoints() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _circleDot(),
        _circleDot(),
      ],
    );
  }

  Icon _circleDot() {
    return Icon(
      Icons.trip_origin,
      size: dotSize,
      color: color,
    );
  }
}

final class _VDash extends StatelessWidget {
  final double width;
  final Color color;

  const _VDash({
    this.width = 2,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        final boxHeight = constraints.constrainHeight();
        const double dashHeight = 7;
        final dashWidth = width;
        final dashCount = (boxHeight / (2 * dashHeight)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
          children: List.generate(
            dashCount,
            (index) => SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            ),
          ),
        );
      }),
    );
  }
}
