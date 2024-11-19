import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ffi';
import 'package:eb_uikit/eb_uikit.dart';
import 'package:eb_resource/eb_resource.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

part 'mock_scrollwithheader.dart';
part 'mock_ebroundedbutton.dart';
part 'mock_ebtextfield.dart';
part 'mock_eb_images.dart';
part 'mock_eb_fonts.dart';
part 'mock_loadingview.dart';
part 'mock_snap_card_view.dart';

class EBUIkitExample extends StatelessWidget {
  const EBUIkitExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: _MockScrollWithHeader(),
      // home: _MockEBRoundedButton(),
      // home: _MockEBTextField(),
      // home: _MockEBImages(),
      // home: MockEBFonts(),
      // home: MockLoadingView(),
      home: _MockSnapCardView(),
    );
  }
}
