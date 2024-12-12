part of '../../eb_uikit.dart';

WidgetBuilder builderModalBottomSheet({
  required BuildContext context,
  required MaterialPageRoute onGenerateRoute,
}) {
  return (context) => Material(
        child: Navigator(
          onGenerateRoute: (context) => onGenerateRoute,
        ),
      );
}

final class MockModalBottomSheetButton extends StatelessWidget {
  final MaterialPageRoute modalView;

  const MockModalBottomSheetButton({
    super.key,
    required this.modalView,
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
              _modal(context);
            },
            child: const Text("Modal Bottom Sheet")),
      ),
    );
  }

  void _modal(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      backgroundColor: Colors.white,
      builder: builderModalBottomSheet(
        context: context,
        onGenerateRoute: modalView,
      ),
    );
  }
}
