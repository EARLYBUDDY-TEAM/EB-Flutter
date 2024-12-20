import 'package:eb_login/eb_login.dart';
import 'package:flutter/material.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_delegate/eb_delegate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mock_loginview.dart';

// required EBAuthRepository authRepository,
//     required TokenRepository tokenRepository,
//     required HomeDelegate homeDelegate,
//     required LoginDelegate loginDelegate,
//     required RootDelegate rootDelegate,

final class LoginExample extends StatelessWidget {
  final _ebAuthRepository = EBAuthRepository();
  final _tokenRepository = EBTokenRepository();
  final _homeDelegate = HomeDelegate();
  final _loginDelegate = LoginDelegate();
  final _rootDelegate = RootDelegate();

  LoginExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _ebAuthRepository),
        RepositoryProvider.value(value: _tokenRepository),
        RepositoryProvider.value(value: _homeDelegate),
        RepositoryProvider.value(value: _loginDelegate),
        RepositoryProvider.value(value: _rootDelegate),
      ],
      child: const MaterialApp(
        home: MockLoginView(),
      ),
    );
  }
}
