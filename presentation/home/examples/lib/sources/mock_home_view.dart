part of 'home_example.dart';

final class MockHomeView extends StatelessWidget {
  final _homeDelegate = HomeDelegate();
  final _loadingDelegate = LoadingDelegate();
  final _homeRepository = HomeRepository();
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
        homeRepository: RepositoryProvider.of<HomeRepository>(context),
        tokenEvent: RepositoryProvider.of<TokenEvent>(context),
      )..add(
          InitHomeState(
            homeState: HomeState(
              scheduleCardList: mockData(),
            ),
          ),
        ),
      child: _MockHomeAppView(),
    );
  }

  List<ScheduleCard> mockData() {
    return [
      ScheduleCard.mock(),
      ScheduleCard.mockwithPlace(),
      ScheduleCard.mock(),
      ScheduleCard.mockwithPlace(),
      ScheduleCard.mock(),
      ScheduleCard.mockwithPlace(),
      ScheduleCard.mock(),
      ScheduleCard.mockwithPlace(),
      ScheduleCard.mock(),
      ScheduleCard.mockwithPlace(),
      ScheduleCard.mock(),
      ScheduleCard.mockwithPlace(),
    ];
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
