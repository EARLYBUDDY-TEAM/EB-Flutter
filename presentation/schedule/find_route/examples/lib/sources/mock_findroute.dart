part of 'findroute_example.dart';

final class _MockFindRouteView extends StatelessWidget {
  final addScheduleDelegate = AddScheduleDelegate();
  final findRouteDelegate = FindRouteDelegate();
  final findRouteRepository = FindRouteRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: addScheduleDelegate),
        RepositoryProvider.value(value: findRouteDelegate),
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
      pageChangeStartPlace: _MockPageChangeSearchView.start,
      pageChangeEndPlace: _MockPageChangeSearchView.end,
    );
  }
}

final class _MockPageChangeSearchView extends StatelessWidget {
  final String title;

  static MaterialPageRoute Function(BuildContext) get start {
    return (context) => MaterialPageRoute(
          builder: (context) => const _MockPageChangeSearchView(title: "start"),
        );
  }

  static MaterialPageRoute Function(BuildContext) get end {
    return (context) => MaterialPageRoute(
          builder: (context) => const _MockPageChangeSearchView(title: "end"),
        );
  }

  const _MockPageChangeSearchView({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(title),
      ),
    );
  }
}
