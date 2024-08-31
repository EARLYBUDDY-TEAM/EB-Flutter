import 'package:eb_login/eb_login.dart';
import 'package:flutter/material.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_delegate/eb_delegate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mock_loginview.dart';

final class LoginExample extends StatelessWidget {
  final _ebAuthRepository = EBAuthRepository();
  final _loginDelegate = LoginDelegate();

  LoginExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _ebAuthRepository),
        RepositoryProvider.value(value: _loginDelegate),
      ],
      child: const MaterialApp(
        home: MockLoginView(),
      ),
    );
  }
}
