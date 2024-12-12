part of 'home_example.dart';

final class MockRegisterConfettiView extends StatelessWidget {
  final homeDelegate = HomeDelegate();

  MockRegisterConfettiView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WithRegisterConfettiView(
        homeDelegate: homeDelegate,
        child: const MockRegisterConfettiContent(),
      ),
    );
  }

  void addConfetti() {
    homeDelegate.registerStatus.add("테스트 닉네임");
  }
}

final class MockRegisterConfettiContent extends StatelessWidget {
  const MockRegisterConfettiContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _randomColorBox(),
            _randomColorBox(),
            // _randomColorBox(),
            // _randomColorBox(),
            // _randomColorBox(),
          ],
        ),
      ),
    );
  }

  Widget _randomColorBox() {
    return Container(
      color: EBColors.random,
      width: 300,
      height: 300,
    );
  }
}
