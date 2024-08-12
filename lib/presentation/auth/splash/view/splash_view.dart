import 'package:earlybuddy/shared/eb_uikit/eb_resources.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashView());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: EBImages.splash, fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
