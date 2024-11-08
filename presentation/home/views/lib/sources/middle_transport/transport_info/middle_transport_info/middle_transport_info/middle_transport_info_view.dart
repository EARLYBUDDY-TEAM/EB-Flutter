part of '../../../../../eb_home.dart';

final class MiddleTransportInfoView extends StatelessWidget {
  final int currentIndex;
  final List<InfoMiddleTransportCardState> cardStateList;
  final Stream<RealTimeInfo?> streamRealTimeInfo;
  final double horizontalPadding;

  const MiddleTransportInfoView({
    super.key,
    required this.currentIndex,
    required this.horizontalPadding,
    required this.cardStateList,
    required this.streamRealTimeInfo,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = ScreenSize.width(context) - (20 * 2);

    return ListView.separated(
      physics: _SnapPageScrollPhysics(
        elementPadding: horizontalPadding,
        elementWidth: cardWidth,
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      scrollDirection: Axis.horizontal,
      itemBuilder: _itemBuilder(itemWidth: cardWidth),
      itemCount: cardStateList.length,
      separatorBuilder: _separatorBuilder,
    );
  }

  Widget Function(BuildContext, int) get _separatorBuilder {
    return (context, index) => SizedBox(
          width: horizontalPadding,
        );
  }

  Widget? Function(BuildContext, int) _itemBuilder({
    required double itemWidth,
  }) {
    return (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
          width: itemWidth,
          child: MiddleTransportInfoCard(
            index: index,
            cardState: cardStateList[index],
            streamRealTimeInfo:
                (currentIndex == index) ? streamRealTimeInfo : null,
          ),
        ),
      );
    };
  }

  Widget mockItem({
    required double itemWidth,
    required int index,
  }) {
    return Container(
      width: itemWidth,
      color: EBColors.random,
      child: Center(child: Text("Index : $index")),
    );
  }
}

final class _SnapPageScrollPhysics extends ScrollPhysics {
  const _SnapPageScrollPhysics({
    super.parent,
    required this.elementWidth,
    required this.elementPadding,
  });

  final double elementWidth;
  final double elementPadding;

  @override
  _SnapPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SnapPageScrollPhysics(
      parent: buildParent(ancestor),
      elementWidth: elementWidth,
      elementPadding: elementPadding,
    );
  }

  double _getTargetPixels(
    ScrollMetrics position,
    Tolerance tolerance,
    double velocity,
  ) {
    final pageWidth = elementWidth + elementPadding;
    final page = position.pixels / pageWidth + velocity / 3000;
    final offset = (position.viewportDimension - elementWidth) / 2;
    final target = page.roundToDouble() * pageWidth - offset + elementPadding;
    return math.max(0, math.min(target, position.maxScrollExtent));
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final tolerance = toleranceFor(position);
    final target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
        tolerance: tolerance,
      );
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
