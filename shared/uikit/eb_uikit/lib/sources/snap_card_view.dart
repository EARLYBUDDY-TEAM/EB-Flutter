part of '../eb_uikit.dart';

final class SnapCardView extends StatefulWidget {
  final int cardCount;
  final int initialIndex;
  final double listHorizontalPadding;
  final double cardSpacing;
  final Function(int index) onChangeIndex;
  final Widget? Function(BuildContext, int) Function(
      {required double cardWidth}) itemBuilder;

  const SnapCardView({
    super.key,
    required this.cardCount,
    required this.initialIndex,
    required this.onChangeIndex,
    required this.listHorizontalPadding,
    required this.cardSpacing,
    required this.itemBuilder,
  });

  @override
  State<StatefulWidget> createState() => _SnapCardViewState();
}

final class _SnapCardViewState extends State<SnapCardView> {
  late ScrollController _scrollController;
  late int tmpIndex;

  Function() _scrollListener({
    required double screenWidth,
  }) {
    return () {
      final expectIndex = (_scrollController.offset / screenWidth).round();
      if (expectIndex != tmpIndex) {
        tmpIndex = expectIndex;
        widget.onChangeIndex(expectIndex);
      }
    };
  }

  void _setIndex() {
    tmpIndex = widget.initialIndex;
  }

  @override
  void didUpdateWidget(covariant SnapCardView oldWidget) {
    if (oldWidget.initialIndex != widget.initialIndex) {
      _setIndex();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _setIndex();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = ScreenSize.width(context);
    final cardWidth = screenWidth - (widget.listHorizontalPadding * 2);
    final rest = screenWidth -
        widget.listHorizontalPadding -
        cardWidth -
        widget.cardSpacing;

    return ListView.separated(
      controller: _scrollController
        ..addListener(
          _scrollListener(
            screenWidth: screenWidth,
          ),
        ),
      physics: _SnapPageScrollPhysics(
        elementPadding: widget.cardSpacing,
        elementWidth: cardWidth,
        rest: rest,
      ),
      padding: EdgeInsets.symmetric(horizontal: widget.listHorizontalPadding),
      scrollDirection: Axis.horizontal,
      itemBuilder: widget.itemBuilder(cardWidth: cardWidth),
      itemCount: widget.cardCount,
      separatorBuilder: _separatorBuilder(cardSpacing: widget.cardSpacing),
    );
  }

  Widget Function(BuildContext, int) _separatorBuilder({
    required double cardSpacing,
  }) {
    return (context, index) => SizedBox(width: cardSpacing);
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
