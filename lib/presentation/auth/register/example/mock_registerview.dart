part of 'register_example.dart';

final class _MockRegisterView extends StatelessWidget {
  const _MockRegisterView();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EBAuthRepository(),
      child: const RegisterView(),
    );
  }
}
