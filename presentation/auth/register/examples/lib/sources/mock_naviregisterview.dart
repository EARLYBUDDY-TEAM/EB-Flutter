part of 'register_example.dart';

final class _MockNaviRegisterView extends StatelessWidget {
  const _MockNaviRegisterView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RegisterView(),
              ),
            );
          },
          child: const Text('Navi to RegisterView'),
        ),
      ),
    );
  }
}
