part of '../../../../../eb_home.dart';

final class MiddleTransportInfoView extends StatefulWidget {
  final int currentIndex;
  final List<InfoMiddleTransportCardState> cardStateList;
  final Stream<RealTimeInfo?> streamRealTimeInfo;
  final double horizontalPadding;
  final double spacing = 15;

  const MiddleTransportInfoView({
    super.key,
    required this.currentIndex,
    required this.cardStateList,
    required this.streamRealTimeInfo,
    required double horizontalPadding,
  }) : horizontalPadding = horizontalPadding + 5;

  @override
  State<StatefulWidget> createState() => MiddleTransportInfoViewState();
}

final class MiddleTransportInfoViewState
    extends State<MiddleTransportInfoView> {
  late ScrollController _scrollController;
  late int tmpIndex;

  Function() _scrollListener({
    required BuildContext context,
    required double screenWidth,
  }) {
    return () {
      final expectIndex = (_scrollController.offset / screenWidth).round();
      if (expectIndex != tmpIndex) {
        tmpIndex = expectIndex;
        context.read<MiddleTranportBloc>().add(
              ChangeTransportInfoCard(expectIndex: expectIndex),
            );
      }
    };
  }

  @override
  void didUpdateWidget(covariant MiddleTransportInfoView oldWidget) {
    if (oldWidget.currentIndex != widget.currentIndex) {
      tmpIndex = widget.currentIndex;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    tmpIndex = widget.currentIndex;
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = ScreenSize.width(context);
    final cardWidth = screenWidth - (widget.horizontalPadding * 2);
    final rest =
        screenWidth - widget.horizontalPadding - cardWidth - widget.spacing;

    return ListView.separated(
      controller: _scrollController
        ..addListener(
          _scrollListener(
            context: context,
            screenWidth: screenWidth,
          ),
        ),
      physics: _SnapPageScrollPhysics(
        elementPadding: widget.spacing,
        elementWidth: cardWidth,
        rest: rest,
      ),
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
      scrollDirection: Axis.horizontal,
      itemBuilder: _itemBuilder(itemWidth: cardWidth),
      itemCount: widget.cardStateList.length,
      separatorBuilder: _separatorBuilder(spacing: widget.spacing),
    );
  }

  Widget Function(BuildContext, int) _separatorBuilder({
    required double spacing,
  }) {
    return (context, index) => SizedBox(width: spacing);
  }

  Widget? Function(BuildContext, int) _itemBuilder({
    required double itemWidth,
  }) {
    return (context, index) {
      final streamRealTimeInfo =
          (widget.currentIndex == index) ? widget.streamRealTimeInfo : null;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
          width: itemWidth,
          child: MiddleTransportInfoCard(
            index: index,
            cardState: widget.cardStateList[index],
            streamRealTimeInfo: streamRealTimeInfo,
          ),
        ),
      );
    };
  }
}

final class _SnapPageScrollPhysics extends ScrollPhysics {
  const _SnapPageScrollPhysics({
    super.parent,
    required this.elementWidth,
    required this.elementPadding,
    required this.rest,
  });

  final double elementWidth;
  final double elementPadding;
  final double rest;

  @override
  _SnapPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SnapPageScrollPhysics(
      parent: buildParent(ancestor),
      rest: rest,
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
    final target =
        page.roundToDouble() * pageWidth - offset + elementPadding + rest;
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
