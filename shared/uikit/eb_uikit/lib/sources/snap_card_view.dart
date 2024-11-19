part of '../eb_uikit.dart';

final class SnapCardScrollController extends ScrollController {
  final int cardCount;
  final double cardWidth;
  final double cardSpacing;
  final double cardRest;
  final Function(int index)? onChangeIndex;

  SnapCardScrollController({
    required this.cardCount,
    required this.cardWidth,
    required this.cardSpacing,
    required this.cardRest,
    this.onChangeIndex,
  });

  static SnapCardScrollController initWithScreenWidth({
    required double screenWidth,
    required double cardSpacing,
    required double cardRest,
    required int cardCount,
    Function(int index)? onChangeIndex,
  }) {
    final cardWidth = screenWidth - ((cardSpacing + cardRest) * 2);
    return SnapCardScrollController(
      cardCount: cardCount,
      cardSpacing: cardSpacing,
      cardRest: cardRest,
      onChangeIndex: onChangeIndex,
      cardWidth: cardWidth,
    );
  }

  void moveTo({
    required int index,
  }) {
    final double offset = (cardWidth + cardSpacing) * index;
    animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}

// final class SnapCardView extends StatefulWidget {

//   const SnapCardView({
//     super.key,
//     required this.scrollController,
//     required this.itemBuilder,
//   });

//   @override
//   State<StatefulWidget> createState() => _SnapCardViewState();
// }

final class SnapCardView extends StatelessWidget {
  final Widget? Function(BuildContext, int) Function({
    required double cardWidth,
  }) itemBuilder;
  final SnapCardScrollController controller;
  int tmpIndex = 0;

  SnapCardView({
    super.key,
    required this.itemBuilder,
    required this.controller,
  });

  SnapCardScrollController get _scrollController {
    final onChangeIndex = controller.onChangeIndex;
    final cardWidth = controller.cardWidth;
    final cardSpacing = controller.cardSpacing;

    if (onChangeIndex != null) {
      controller.addListener(() {
        final expectIndex =
            ((controller.offset) / (cardWidth + cardSpacing)).round();
        if (expectIndex != tmpIndex) {
          tmpIndex = expectIndex;
          onChangeIndex(expectIndex);
        }
      });
    }
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    final c = controller;
    final horizontalPadding = (c.cardSpacing + c.cardRest);

    return ListView.separated(
      controller: _scrollController,
      physics: _SnapPageScrollPhysics(
        elementPadding: c.cardSpacing,
        elementWidth: c.cardWidth,
        rest: c.cardRest,
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      scrollDirection: Axis.horizontal,
      itemBuilder: itemBuilder(cardWidth: c.cardWidth),
      itemCount: c.cardCount,
      separatorBuilder: _separatorBuilder(cardSpacing: c.cardSpacing),
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
