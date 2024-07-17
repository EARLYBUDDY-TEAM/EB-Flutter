import 'package:earlybuddy/shared/eb_uikit/resources/eb_resources.dart';
import 'package:earlybuddy/shared/eb_uikit/sources/eb_sources.dart';
import 'package:flutter/material.dart';

part 'mock_scrollwithheader.dart';

class EBUIkitExample extends StatelessWidget {
  const EBUIkitExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _MockScrollWithHeader(),
    );
  }
}
