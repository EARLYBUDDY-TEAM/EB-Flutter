part of '../home_example.dart';

final class MockRegisterConfettiApp extends StatelessWidget {
  const MockRegisterConfettiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WithRegisterConfettiView(
        child: MockRegisterConfettiBackground(),
      ),
    );
  }
}

final class MockRegisterConfettiBackground extends StatelessWidget {
  const MockRegisterConfettiBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              randomColorBox(),
              randomColorBox(),
              randomColorBox(),
              randomColorBox(),
              randomColorBox(),
              randomColorBox(),
              randomColorBox(),
              // _randomColorBox(),
              // _randomColorBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget randomColorBox() {
    return Container(
      color: EBColors.random,
      width: 300,
      height: 300,
    );
  }
}
