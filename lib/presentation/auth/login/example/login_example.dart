import 'package:earlybuddy/domain/repository/repository.dart';
import 'package:earlybuddy/presentation/auth/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mock_loginview.dart';

class LoginExample extends StatelessWidget {
  const LoginExample({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EBAuthRepository(),
      child: const MaterialApp(
        home: MockLoginView(),
      ),
    );
  }
}
