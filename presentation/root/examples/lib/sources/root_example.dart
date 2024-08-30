import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:eb_uikit/eb_uikit.dart';
import 'package:eb_root/eb_root.dart';
import 'package:eb_model/eb_model.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_delegate/eb_delegate.dart';

part 'mock_rootview.dart';

class RootExample extends StatelessWidget {
  final _mockAutoLoginRootView = _MockAutoLoginRootView();

  RootExample({super.key});

  @override
  Widget build(BuildContext context) {
    return _mockAutoLoginRootView;
  }

  Future<void> init() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    await _mockAutoLoginRootView.setAutoLogin();
  }
}
