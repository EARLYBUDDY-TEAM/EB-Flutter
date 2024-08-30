part of '../eb_root.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashView());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Assets.images.splash.image(
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
