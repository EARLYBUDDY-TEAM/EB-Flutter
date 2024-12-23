part of '../home_example.dart';

final mockSchedulePathList = mockSchedulePath();
List<String> getTransportNameList() {
  final transportList =
      mockSchedulePathList.first.ebPath!.ebSubPathList.first.transportList;
  return transportList.map<String>(
    (t) {
      switch (t) {
        case Subway():
          return t.type;
        case Bus():
          return t.number;
      }
    },
  ).toList();
}

final class MockHomeView extends StatelessWidget {
  final _loadingDelegate = LoadingDelegate();
  final _homeDelegate = HomeDelegate();
  final _findrouteDelegate = FindRouteDelegate();
  final _addScheduleDelegate = AddScheduleDelegate();
  late final HomeRepositoryAB _homeRepository = TestHomeRepository(
    schedulePathList: mockSchedulePathList,
    transportNameList: getTransportNameList(),
  );

  // final HomeRepositoryAB _homeRepository = HomeRepository();
  final _scheduleRepository = ScheduleRepository();
  final _findrouteRepository = FindRouteRepository();
  // final _subwayScheduleProvider = SubwayScheduleProvider();

  // late final _tokenEvent = TokenEvent(
  //   rootDelegate: RootDelegate(),
  //   loginDelegate: LoginDelegate(),
  //   tokenRepository: TokenRepository(),
  // );
  // late final _scheduleEvent = ScheduleEvent(
  //   loadingDelegate: _loadingDelegate,
  //   scheduleRepository: _scheduleRepository,
  //   tokenEvent: _tokenEvent,
  // );

  MockHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _loadingDelegate),
        RepositoryProvider.value(value: _homeDelegate),
        RepositoryProvider.value(value: _findrouteDelegate),
        RepositoryProvider.value(value: _addScheduleDelegate),
        RepositoryProvider.value(value: _homeRepository),
        RepositoryProvider.value(value: _findrouteRepository),
      ],
      child: MaterialApp(home: _MockHomeBlocProviderView()),
    );
  }
}

final class _MockHomeBlocProviderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = HomeBloc(
          loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
          homeDelegate: RepositoryProvider.of<HomeDelegate>(context),
          homeRepository: RepositoryProvider.of<HomeRepositoryAB>(context),
          tokenEvent: RepositoryProvider.of<EBTokenEvent>(context),
          scheduleEvent: RepositoryProvider.of<ScheduleEvent>(context),
          cancelModalViewAction: () {
            Navigator.of(context).pop();
          },
        )..add(OnAppearHomeView());

        return bloc;
      },
      child: _MockHomeAppView(),
      // child: const MockMiddleTransportView(),
    );
  }
}

final class _MockHomeAppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const EBHomeView();
  }
}
