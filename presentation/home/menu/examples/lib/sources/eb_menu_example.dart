import 'package:flutter/material.dart';
import 'package:eb_menu/eb_menu.dart';
import 'package:eb_uikit/eb_uikit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_delegate/eb_delegate.dart';
import 'package:eb_event/eb_event.dart';
import 'package:eb_menu_feature/eb_menu_feature.dart';

part 'mock_menu_view.dart';
part 'mock_complete_change_password_view.dart';
part 'mock_opensource_license_list_view.dart';

final class EBMenuExample extends StatelessWidget {
  const EBMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MockMenuView();
  }
}
