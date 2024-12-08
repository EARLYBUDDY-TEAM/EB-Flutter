part of '../../eb_uikit.dart';

final class NavigatorPushExampleHelper extends StatelessWidget {
  final Widget child;

  const NavigatorPushExampleHelper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => child,
              ),
            );
          },
          child: const Text('Push Child View'),
        ),
      ),
    );
  }
}
