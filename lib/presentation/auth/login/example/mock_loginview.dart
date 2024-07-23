part of 'login_example.dart';

class MockLoginView extends StatelessWidget {
  const MockLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EBAuthRepository(),
      child: const LoginView(),
    );
  }
}
