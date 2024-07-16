part of 'searchplace_example.dart';

final class _MockModalSearchPlaceForRoute extends StatelessWidget {
  final delegate = SearchPlaceDelegateForRoute();
  static const routeName = 'MockModalSearchPlaceForRoute';

  _MockModalSearchPlaceForRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => delegate,
      child: MaterialApp(
        onGenerateRoute: (settings) => MaterialPageRoute(
          settings: const RouteSettings(name: routeName),
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

  void selectAction(
    BuildContext context1,
    BuildContext context2,
  ) {
    final start = Coordi.mockStart();
    final end = Coordi.mockEnd();
    Navigator.push(
      context2,
      MaterialPageRoute(
        builder: (context2) => FindRouteView(
          start: start,
          end: end,
          cancelAction: () {
            Navigator.of(context1).popUntil(
              ModalRoute.withName(
                _MockModalSearchPlaceForRoute.routeName,
              ),
            );
            Navigator.of(context1).pop();
          },
        ),
      ),
    );
  }

  void onPressed(BuildContext context) {
    showCupertinoModalBottomSheet(
      settings: const RouteSettings(name: SearchPlaceView.routeName),
      context: context,
      expand: true,
      backgroundColor: Colors.white,
      builder: (context) => Material(
        child: Navigator(
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (context) => Builder(
              builder: (context2) => SearchPlaceView(
                setting: SearchPlaceSetting.departure,
                delegate:
                    RepositoryProvider.of<SearchPlaceDelegateForRoute>(context),
                searchPlaceState: SearchPlaceState.mockStarBucks(),
                selectAction: () => selectAction(context, context2),
                cancelAction: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
