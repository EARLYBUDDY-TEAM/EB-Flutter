part of 'searchplace_example.dart';

class MockModalSearchPlace extends StatelessWidget {
  const MockModalSearchPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: TextButton(
              child: const Text('Push SearchPlaceView'),
              onPressed: () => onPressed(context),
            ),
          ),
        ),
      ),
    );
  }

  void onPressed(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      expand: true,
      backgroundColor: Colors.white,
      builder: (context) => const SearchPlaceView(),
    );
  }
}
