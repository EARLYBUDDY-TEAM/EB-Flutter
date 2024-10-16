part of 'addschedule_example.dart';

final class MockAddSchedule extends StatelessWidget {
  final loadingDelegate = LoadingDelegate();
  final rootDelegate = RootDelegate();
  final loginDelegate = LoginDelegate();
  final addScheduleDelegate = AddScheduleDelegate();
  final scheduleRepository = ScheduleRepository();
  final tokenRepository = TokenRepository();

  final searchPlaceDelegate = SearchPlaceDelegate();
  final searchPlaceRepository = SearchPlaceRepository();

  late final tokenEvent = TokenEvent(
    rootDelegate: rootDelegate,
    loginDelegate: loginDelegate,
    tokenRepository: tokenRepository,
  );

  MockAddSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: loadingDelegate),
        RepositoryProvider.value(value: rootDelegate),
        RepositoryProvider.value(value: loginDelegate),
        RepositoryProvider.value(value: addScheduleDelegate),
        RepositoryProvider.value(value: scheduleRepository),
        RepositoryProvider.value(value: tokenEvent),
        RepositoryProvider.value(value: searchPlaceDelegate),
        RepositoryProvider.value(value: searchPlaceRepository),
      ],
      child: MaterialApp(
        home: _NaviButton(
          toShow: const AddScheduleView(),
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
                builder: (_) => toShow,
              ),
            );
          },
          child: const Text('Navi AddScheduleView'),
        ),
      ),
    );
  }
}
