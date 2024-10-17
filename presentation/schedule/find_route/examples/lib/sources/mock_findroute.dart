part of 'findroute_example.dart';

final class _MockFindRouteView extends StatelessWidget {
  final addScheduleDelegate = AddScheduleDelegate();
  final searchPlaceDelegate = SearchPlaceDelegate();
  final findRouteRepository = FindRouteRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: addScheduleDelegate),
        RepositoryProvider.value(value: searchPlaceDelegate),
        RepositoryProvider.value(value: findRouteRepository),
      ],
      child: MaterialApp(
        home: _NaviButton(
          toShow: _MockFindRouteContent(),
          onPressed: () {},
        ),
      ),
    );
  }
}

final class _NaviButton extends StatelessWidget {
  final StatelessWidget toShow;
  final Function() onPressed;

  const _NaviButton({
    required this.toShow,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            onPressed();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (contxt) => toShow,
              ),
            );
          },
          child: const Text('Navi FindRouteView'),
        ),
      ),
    );
  }
}

final class _MockFindRouteContent extends StatelessWidget {
  final startPlace = Place.mockStart();
  final endPlace = Place.mockEnd();

  @override
  Widget build(BuildContext context) {
    return FindRouteView(
      parentName: "naviButton",
      startPlace: startPlace,
      endPlace: endPlace,
    );
  }
}
