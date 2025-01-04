part of 'eb_uikit_example.dart';

const maxCount = 3;
final cards = List<int>.generate(maxCount, (i) => i);
final _currentIndexSubject = BehaviorSubject.seeded(0);

final _random = math.Random();

class EBRandom {
  static int nexInt({
    int min = 0,
    int max = 3,
  }) {
    return min + _random.nextInt(max - min);
  }
}

final class _MockSnapCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _MockSnapCardWithButton(),
      ),
    );
  }
}

final class _MockSnapCardWithButton extends StatelessWidget {
  late SnapCardScrollController scrollController;

  Function(int)? get _onChangeIndex {
    return (int index) {
      _currentIndexSubject.add(index);
    };
  }

  @override
  Widget build(BuildContext context) {
    const double cardSpacing = 20;
    const double cardRest = 30;
    final screenWidth = ScreenSize.width(context);

    scrollController = SnapCardScrollController.initWithScreenWidth(
      cardCount: cards.length,
      screenWidth: screenWidth,
      cardSpacing: cardSpacing,
      cardRest: cardRest,
      onChangeIndex: _onChangeIndex,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 300,
          child: _MockSnapCardViewContent(
            snapCardScrollController: scrollController,
          ),
        ),
        const SizedBox(height: 10),
        _RandomIndexButton(
          getRandomIndex: (randomIndex) {
            _currentIndexSubject.add(randomIndex);
            scrollController.moveTo(index: randomIndex);
          },
        )
      ],
    );
  }
}

final class _RandomIndexButton extends StatefulWidget {
  final Function(int) getRandomIndex;

  const _RandomIndexButton({
    super.key,
    required this.getRandomIndex,
  });

  @override
  State<StatefulWidget> createState() => _RandomIndexButtonState();
}

final class _RandomIndexButtonState extends State<_RandomIndexButton> {
  int currentIndex = 0;
  late StreamSubscription<int> _subscription;

  @override
  void initState() {
    _subscription = _currentIndexSubject.listen((index) {
      setState(() {
        currentIndex = index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final randomIndex = EBRandom.nexInt();
        widget.getRandomIndex(randomIndex);
      },
      child: Text("CurIndex : $currentIndex"),
    );
  }
}

final class _MockSnapCardViewContent extends StatelessWidget {
  final SnapCardScrollController snapCardScrollController;

  const _MockSnapCardViewContent({
    super.key,
    required this.snapCardScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SnapCardView(
      itemBuilder: _itemBuilder,
      scrollController: snapCardScrollController,
    );
  }

  Widget? Function(BuildContext, int) _itemBuilder({
    required double cardWidth,
  }) {
    return (context, int) {
      return Container(
        width: cardWidth,
        height: cardWidth,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: EBColors.random,
        ),
        child: Center(
          child: Text("Index : $int"),
        ),
      );
    };
  }
}
