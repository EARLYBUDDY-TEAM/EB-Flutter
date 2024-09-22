import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eb_register/eb_register.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_delegate/eb_delegate.dart';

part 'mock_naviregisterview.dart';
part 'mock_registerview.dart';

final class RegisterExample extends StatelessWidget {
  final _ebAuthRepository = EBAuthRepository();
  final _homeDelegate = HomeDelegate();

  RegisterExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _ebAuthRepository),
        RepositoryProvider.value(value: _homeDelegate),
      ],
      child: const MockRegisterApp(),
    );
  }
}

final class MockRegisterApp extends StatelessWidget {
  const MockRegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: _MockNaviRegisterView(),
      home: _MockRegisterView(),
    );
  }
}
