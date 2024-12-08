import 'package:flutter/material.dart';
import 'package:eb_menu/eb_menu.dart';
import 'package:eb_uikit/eb_uikit.dart';

part 'mock_complete_change_password_view.dart';

final class EBMenuExample extends StatelessWidget {
  const EBMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NavigatorPushExampleHelper(
        child: MockCompleteChangePasswordView(),
      ),
    );
  }
}
