part of 'home_example.dart';

List<Schedule> mockScheduleCardList() {
  final List<Schedule> mockScheduleList = [];
  final today = DateTime.now();
  final yesterday = today.add(const Duration(days: -1));
  // final nextDay = today.add(const Duration(days: 1));

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
    mockScheduleList.add(Schedule.mock(time: yesterday));
  }
  return mockScheduleList;
}

final class MockHomeView extends StatelessWidget {
  final _homeDelegate = HomeDelegate();
  final _loadingDelegate = LoadingDelegate();
  final HomeRepositoryAB _homeRepository =
      TestHomeRepository(scheduleList: mockScheduleCardList());
  late final _tokenEvent = TokenEvent(
    rootDelegate: RootDelegate(),
    loginDelegate: LoginDelegate(),
    tokenRepository: TokenRepository(),
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
      ],
      child: _MockHomeBlocProviderView(),
    );
  }
}

final class _MockHomeBlocProviderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
        homeDelegate: RepositoryProvider.of<HomeDelegate>(context),
        homeRepository: RepositoryProvider.of<HomeRepositoryAB>(context),
        tokenEvent: RepositoryProvider.of<TokenEvent>(context),
      )..add(const OnAppearHomeView()),
      child: _MockHomeAppView(),
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
