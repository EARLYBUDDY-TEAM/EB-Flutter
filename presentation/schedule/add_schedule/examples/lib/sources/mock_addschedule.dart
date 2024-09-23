part of 'addschedule_example.dart';

final class MockAddSchedule extends StatelessWidget {
  final _scheduleRepository = ScheduleRepository();
  final _ebAuthRepository = EBAuthRepository();

  final _searchPlaceDelegateForPlace = SearchPlaceDelegateForPlace();
  final _searchPlaceDelegateForRoute = SearchPlaceDelegateForRoute();
  final _loginDelegate = LoginDelegate();

  late final bloc = AddScheduleBloc(
    searchPlaceDelegateForPlace: _searchPlaceDelegateForPlace,
    searchPlaceDelegateForRoute: _searchPlaceDelegateForRoute,
    scheduleRepository: _scheduleRepository,
    ebAuthRepository: _ebAuthRepository,
    loginDelegate: _loginDelegate,
  );

  MockAddSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _searchPlaceDelegateForPlace),
        RepositoryProvider.value(value: _searchPlaceDelegateForRoute),
        RepositoryProvider.value(value: _scheduleRepository),
        RepositoryProvider.value(value: _ebAuthRepository),
        RepositoryProvider.value(value: _loginDelegate),
      ],
      child: MaterialApp(
        home: _NaviButton(
          toShow: AddScheduleView(bloc: bloc),
          onPressed: () async {
            await setAddScheduleResult();
          },
        ),
      ),
    );
  }

  Future<void> setAddScheduleResult() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    bloc.add(const SetAddScheduleResult(result: AddScheduleResult.fail));
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
