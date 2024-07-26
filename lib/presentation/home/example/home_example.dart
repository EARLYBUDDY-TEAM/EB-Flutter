import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/presentation/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mock_homeview.dart';

class HomeExample extends StatelessWidget {
  const HomeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EBAuthRepository(),
      child: const MaterialApp(
        home: MockHomeView(),
      ),
    );
  }
}
