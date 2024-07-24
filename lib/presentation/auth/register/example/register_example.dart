import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/presentation/auth/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mock_naviregisterview.dart';
part 'mock_registerview.dart';

final class RegisterExample extends StatelessWidget {
  const RegisterExample({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EBAuthRepository(),
      child: const MaterialApp(
        home: _MockNaviRegisterView(),
        // home: _MockRegisterView(),
      ),
    );
  }
}
