import 'package:earlybuddy/domain/repository/searchplace/source/model/model.dart';
import 'package:earlybuddy/presentation/schedule/ebkakaomap/ebkakaomap.dart';
import 'package:flutter/material.dart';

part 'mock_ebkakaomap.dart';

class EBKakaoMapExample extends StatelessWidget {
  const EBKakaoMapExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MockEBKakaoMapView(),
    );
  }
}
