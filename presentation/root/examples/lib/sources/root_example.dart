import 'dart:developer';

import 'package:eb_uikit/eb_uikit.dart';
import 'package:eb_root/eb_root.dart';
import 'package:eb_model/eb_model.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_delegate/eb_delegate.dart';
import 'package:eb_state/eb_state.dart';

import 'package:flutter/material.dart';

part 'mock_autologin_view.dart';

class RootExample extends StatelessWidget {
  final _mockAutoLoginRootView = _MockAutoLoginView();

  RootExample({super.key});

  @override
  Widget build(BuildContext context) {
    return _mockAutoLoginRootView;
  }

  Future<void> setAutoLogin() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    await _mockAutoLoginRootView.setAutoLogin();
  }
}
