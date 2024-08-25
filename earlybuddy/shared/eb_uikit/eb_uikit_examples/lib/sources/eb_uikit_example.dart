import 'dart:developer';
import 'package:eb_uikit/eb_uikit.dart';
import 'package:eb_resource/eb_resource.dart';
import 'package:flutter/material.dart';

part 'mock_scrollwithheader.dart';
part 'mock_ebroundedbutton.dart';
part 'mock_ebtextfield.dart';

class EBUIkitExample extends StatelessWidget {
  const EBUIkitExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: _MockScrollWithHeader(),
      // home: _MockEBRoundedButton(),
      home: _MockEBTextField(),
    );
  }
}
