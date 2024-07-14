part of 'searchplace_example.dart';

final class _MockModalSearchPlace extends StatelessWidget {
  final delegate = SearchPlaceDelegate();
  final routeName = '_MockModalSearchPlace';

  _MockModalSearchPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SearchPlaceDelegate(),
      child: MaterialApp(
        onGenerateRoute: (settings) => MaterialPageRoute(
          settings: RouteSettings(name: routeName),
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                child: const Text('Push SearchPlaceView'),
                onPressed: () => onPressed(context),
              ),
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
      builder: (context) => SearchPlaceView(
        setting: SearchPlaceSetting.departure,
        searchPlaceState: SearchPlaceState.mockStarBucks(),
        cancelAction: () => Navigator.of(context).pop(),
      ),
    );
  }
}
