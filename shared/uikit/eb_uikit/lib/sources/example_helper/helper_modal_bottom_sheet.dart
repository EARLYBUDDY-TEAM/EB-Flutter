part of '../../eb_uikit.dart';

WidgetBuilder builderModalBottomSheetWithRoute({
  required BuildContext context,
  required MaterialPageRoute onGenerateRoute,
}) {
  return (context) => Material(
        child: Navigator(
          onGenerateRoute: (context) => onGenerateRoute,
        ),
      );
}

Widget Function(BuildContext) builderModalBottomSheet({
  required BuildContext context,
  required Widget child,
}) {
  return (context) => child;

  // return MaterialPageRoute(
  //   builder: (context) => child,
  // );

  // return (context) => Material(
  //       child: Navigator(
  //         onGenerateRoute: (context) => MaterialPageRoute(
  //           builder: (context) => child,
  //         ),
  //       ),
  //     );
}

final class MockModalBottomSheetButton extends StatelessWidget {
  final Widget child;

  const MockModalBottomSheetButton({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (setting) => MaterialPageRoute(
        builder: (context) => _textButton(context),
      ),
    );
  }

  Widget _textButton(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              showCupertinoModalBottomSheet(
                expand: true,
                context: context,
                backgroundColor: Colors.white,
                builder: builderModalBottomSheet(
                  context: context,
                  child: child,
                ),
              );
            },
            child: const Text("Modal Bottom Sheet")),
      ),
    );
  }
}
