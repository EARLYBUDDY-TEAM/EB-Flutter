part of 'home_example.dart';

List<SchedulePath> mockScheduleCardList() {
  final List<SchedulePath> mockSchedulePathList = [];
  final today = DateTime.now().add(const Duration(minutes: 10));
  final yesterday = today.add(const Duration(days: -1));
  final nextDay = today.add(const Duration(days: 1));

  // for (int i = 1; i < 20; i++) {
  //   final tmpDay = today.add(Duration(days: i));
  //   final tmpSchedule = i % 2 == 0
  //       ? ScheduleCard.mock(time: tmpDay)
  //       : ScheduleCard.mockwithPlace(time: tmpDay);
  //   mockScheduleList.add(tmpSchedule);
  // }

  // for (int i = 1; i < 10; i++) {
  //   mockScheduleList.add(ScheduleCard.mockwithPlace(time: today));
  //   mockScheduleList.add(ScheduleCard.mockwithPlace(time: nextDay));
  // }

  // return mockScheduleList;

  for (int i = 1; i < 10; i++) {
    mockSchedulePathList.add(
      SchedulePath(
        schedule: Schedule.mock(time: yesterday),
      ),
    );

    mockSchedulePathList.add(
      SchedulePath(
        schedule: Schedule.mock(time: today),
      ),
    );

    mockSchedulePathList.add(
      SchedulePath(
        schedule: Schedule.mock(time: nextDay),
      ),
    );
  }
  return mockSchedulePathList;
}

final class MockHomeView extends StatelessWidget {
  final _loadingDelegate = LoadingDelegate();
  final _homeDelegate = HomeDelegate();
  final HomeRepositoryAB _homeRepository =
      TestHomeRepository(schedulePathList: mockScheduleCardList());
  final _scheduleRepository = ScheduleRepository();
  late final _tokenEvent = TokenEvent(
    rootDelegate: RootDelegate(),
    loginDelegate: LoginDelegate(),
    tokenRepository: TokenRepository(),
  );
  late final _scheduleEvent = ScheduleEvent(
    loadingDelegate: _loadingDelegate,
    scheduleRepository: _scheduleRepository,
    tokenEvent: _tokenEvent,
  );

  MockHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _loadingDelegate),
        RepositoryProvider.value(value: _homeDelegate),
        RepositoryProvider.value(value: _homeRepository),
        RepositoryProvider.value(value: _tokenEvent),
        RepositoryProvider.value(value: _scheduleEvent),
      ],
      child: _MockHomeBlocProviderView(),
    );
  }
}

final class _MockHomeBlocProviderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final daySchedule =
            DaySchedule.init(allSchedules: mockScheduleCardList());

        final bloc = HomeBloc(
          loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
          homeDelegate: RepositoryProvider.of<HomeDelegate>(context),
          homeRepository: RepositoryProvider.of<HomeRepositoryAB>(context),
          tokenEvent: RepositoryProvider.of<TokenEvent>(context),
          scheduleEvent: RepositoryProvider.of<ScheduleEvent>(context),
          cancelModalViewAction: () {},
          // )..add(OnAppearHomeView());
        );

        return bloc;
      },
      // child: _MockHomeAppView(),
      child: const MockMiddleTransportView(),
    );
  }
}

final class _MockHomeAppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: EBHomeView(),
    );
  }
}
