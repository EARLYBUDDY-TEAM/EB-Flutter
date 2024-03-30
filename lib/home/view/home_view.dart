import 'package:earlybuddy/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Builder(
              builder: (context) {
                final userID = context.select(
                  (AuthBloc bloc) => bloc.state.user.id,
                );
                return Text('UserID : $userID');
              },
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
            )
          ],
        ),
      ),
    );
  }
}
