import 'dart:developer';

import 'package:earlybuddy/domain/delegate/login_delegate.dart';
import 'package:earlybuddy/shared/eb_model/entity/entity.dart';
import 'package:earlybuddy/core/network/sources/service/service.dart';
import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/presentation/root/view/root_view.dart';
import 'package:flutter/material.dart';

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
