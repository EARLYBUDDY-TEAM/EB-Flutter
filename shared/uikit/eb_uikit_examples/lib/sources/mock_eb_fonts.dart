part of 'eb_uikit_example.dart';

final class MockEBFonts extends StatelessWidget {
  const MockEBFonts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _TestEBFont(),
      ),
    );
  }
}

final class _TestEBFont extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "TESTSETEST, testeastsets",
      style: TextStyle(
        fontFamily: FontFamily.gmarketSansBold,
        fontSize: 30,
      ),
    );
  }
}
