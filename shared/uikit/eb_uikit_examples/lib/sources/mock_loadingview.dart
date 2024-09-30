part of 'eb_uikit_example.dart';

final class MockLoadingView extends StatelessWidget {
  final loadingDelegate = LoadingDelegate();

  MockLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return WithLoadingView(
      loadingDelegate: loadingDelegate,
      child: Scaffold(
        body: ALodingView(onPressed: () async {
          await setLoadingView(seconds: 3);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BLodingView(onPressed: () {
                Navigator.of(context).pop();
              }),
            ),
          );
        }),
      ),
    );
  }

  Future<void> setLoadingView({required int seconds}) async {
    loadingDelegate.set();
    await Future.delayed(Duration(seconds: seconds));
    loadingDelegate.dismiss();
  }
}

final class ALodingView extends StatelessWidget {
  final void Function() onPressed;

  const ALodingView({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TestLoadingView(
      title: "A View",
      onPressed: onPressed,
      color: Colors.amber.shade300,
    );
  }
}

final class BLodingView extends StatelessWidget {
  final void Function() onPressed;

  const BLodingView({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TestLoadingView(
      title: "B View",
      onPressed: onPressed,
      color: Colors.brown.shade300,
    );
  }
}

final class TestLoadingView extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final Color? color;

  const TestLoadingView({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: EBButton(
          name: title,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
