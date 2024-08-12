import 'package:earlybuddy/domain/delegate/login_delegate.dart';
import 'package:earlybuddy/domain/delegate/register_delegate.dart';
import 'package:earlybuddy/domain/repository/repository.dart';
import 'package:earlybuddy/presentation/home/view/home_view.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mock_homeview.dart';
part 'mock_alertregister.dart';
part 'mock_alerthomeview.dart';

class HomeExample extends StatelessWidget {
  const HomeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EBAuthRepository(),
      child: MaterialApp(
        theme: EBTheme.light(),
        // home: const MockHomeView(),
        // home: _MockAlertRegister(),
        home: _MockAlertHomeView(),
      ),
    );
  }
}
