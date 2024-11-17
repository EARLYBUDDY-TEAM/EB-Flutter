part of '../../../../../eb_home.dart';

final class HorizontalScrollCardView<T> extends StatefulWidget {
  final double cardHeight;
  final List<T> itemList;
  final Widget Function(int) cardBuilder;

  const HorizontalScrollCardView({
    super.key,
    required this.cardHeight,
    required this.itemList,
    required this.cardBuilder,
  });

  @override
  State<StatefulWidget> createState() => HorizontalScrollCardViewState();
}

final class HorizontalScrollCardViewState
    extends State<HorizontalScrollCardView> {
  int currentIndex = -1;
  int previousIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.cardHeight,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.7),
        itemCount: widget.itemList.length,
        itemBuilder: _itemBuilder,
        onPageChanged: (int index) {
          setState(() {
            if (currentIndex != -1) {
              previousIndex = currentIndex;
            }
            currentIndex = index;
          });
        },
      ),
    );
  }

  double getAnimationValue(int currentIndex, int widgetIndex, int previousIndex,
      {bool begin = true}) {
    if (widgetIndex == currentIndex) {
      return begin ? 0.9 : 1;
    } else {
      return begin ? 1 : 0.9;
    }
  }

  List<Widget> get cardViewList {
    return List.generate(
      widget.itemList.length,
      (i) => widget.cardBuilder(i),
    ).toList();
  }

  TweenAnimationBuilder _tweenAnimationBuilder(int widgetIndex) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween<double>(
        begin: getAnimationValue(
          currentIndex,
          widgetIndex,
          previousIndex,
        ),
        end: getAnimationValue(
          currentIndex,
          widgetIndex,
          previousIndex,
          begin: false,
        ),
      ),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: cardViewList,
            ),
          ),
        );
      },
    );
  }

  Transform _transform(int widgetIndex) {
    return Transform.scale(
      // this is used when you want to disable animation when initialized the page
      scale: (widgetIndex == 0 && currentIndex == -1) ? 1 : 0.9,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cardViewList,
        ),
      ),
    );
  }

  Widget? Function(BuildContext, int) get _itemBuilder {
    return (context, widgetIndex) {
      return (currentIndex != -1 &&
              (previousIndex == widgetIndex || widgetIndex == currentIndex))
          ? _tweenAnimationBuilder(widgetIndex)
          : _transform(widgetIndex);
    };
  }
}
