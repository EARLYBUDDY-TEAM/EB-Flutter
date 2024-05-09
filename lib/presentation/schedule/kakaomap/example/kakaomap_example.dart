import 'package:earlybuddy/presentation/schedule/kakaomap/view/view.dart';
import 'package:flutter/material.dart';

class KakaoMapExample extends StatelessWidget {
  const KakaoMapExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: KakaoMapView(),
      ),
    );
  }
}
