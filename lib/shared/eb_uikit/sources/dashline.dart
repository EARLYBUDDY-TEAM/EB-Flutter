import 'package:flutter/material.dart';

final class HDashLine extends StatelessWidget {
  final double dotSize = 15;
  final StatelessWidget? stackLine;

  const HDashLine({
    super.key,
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
    return stackLine != null ? [const _HDash(), stackLine!] : [const _HDash()];
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
      color: Colors.grey,
    );
  }
}

final class _HDash extends StatelessWidget {
  final double height;

  const _HDash({
    this.height = 2,
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
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            ),
          ),
        );
      }),
    );
  }
}

final class VDashLine extends StatelessWidget {
  final double dotSize = 15;
  final StatelessWidget? stackLine;

  const VDashLine({
    super.key,
    this.stackLine,
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
    return stackLine != null ? [const _VDash(), stackLine!] : [const _VDash()];
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
      color: Colors.grey,
    );
  }
}

final class _VDash extends StatelessWidget {
  final double width;

  const _VDash({
    this.width = 2,
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
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            ),
          ),
        );
      }),
    );
  }
}
