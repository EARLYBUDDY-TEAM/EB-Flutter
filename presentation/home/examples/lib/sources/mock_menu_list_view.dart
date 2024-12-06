part of 'home_example.dart';

final class MockMenuListView extends StatelessWidget {
  const MockMenuListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: EBTheme().light(),
      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          return MaterialPageRoute(
            builder: (context) => const PushMockMenuListButton(),
          );
        }
        return null;
      },
    );
  }
}

final class PushMockMenuListButton extends StatelessWidget {
  const PushMockMenuListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(HomeMenuListView.route());
          },
          child: const Text("ekbhieaohgieo"),
        ),
      ),
    );
  }
}
