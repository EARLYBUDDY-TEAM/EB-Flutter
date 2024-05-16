part of 'searchplace_example.dart';

class _MockModalSearchPlace extends StatelessWidget {
  const _MockModalSearchPlace({super.key});

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
    final SearchPlaceBloc searchPlaceBloc = SearchPlaceBloc(
      searchPlaceState: SearchPlaceState.mockStarBucks(),
    );

    showCupertinoModalBottomSheet(
      context: context,
      expand: true,
      backgroundColor: Colors.white,
      builder: (context) => SearchPlaceView(searchPlaceBloc: searchPlaceBloc),
    );
  }
}
