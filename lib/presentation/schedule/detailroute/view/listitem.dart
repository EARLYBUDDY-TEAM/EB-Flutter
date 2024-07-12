part of 'detailroute_view.dart';

class DetailRouteListItem extends StatelessWidget {
  const DetailRouteListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        color: Colors.amber.shade200,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              iconTransport(),
              _VDashLine(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    departure(),
                    const Spacer(),
                    destination(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column iconTransport() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.directions_walk),
        Text('약 3분'),
      ],
    );
  }

  Row departure() {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text('서울특별시 광진구 아차산로 463-4'),
        Spacer(),
        EBRoundedButton(text: '지도보기'),
      ],
    );
  }

  Row destination() {
    return const Row(
      children: [
        Text('서울특별시 광진구 아차산로 463-4까지 걷기'),
      ],
    );
  }
}

final class _VDashLine extends StatelessWidget {
  final double dotSize = 15;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _circlePoints(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dotSize),
          child: const Stack(children: [
            _VDash(),
          ]),
        ),
      ],
    );
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
