import 'package:flutter/material.dart';
import 'package:eb_menu/eb_menu.dart';
import 'package:eb_uikit/eb_uikit.dart';

part 'mock_complete_change_password_view.dart';
part 'mock_opensource_license_list_view.dart';

final class EBMenuExample extends StatelessWidget {
  const EBMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: EBTheme().light(),
      home: const NavigatorPushExampleHelper(
        child: MockOpenSourceLicenseListView(),
      ),
    );
  }
}
