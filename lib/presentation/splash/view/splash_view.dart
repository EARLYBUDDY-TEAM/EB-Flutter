import 'package:flutter/material.dart';
import 'package:earlybuddy/shared/assets/image.dart';

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
          decoration: BoxDecoration(
            image: DecorationImage(image: EBImages.splash, fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
