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

final homeDelegate = HomeDelegate();

final class MockHomeView extends StatelessWidget {
  final _loadingDelegate = LoadingDelegate();
  final HomeRepositoryAB _homeRepository = HomeRepository();
  final _rootDelegate = RootDelegate();
  final _ebTokenRepository = EBTokenRepository();
  final _loginDelegate = LoginDelegate();
  final _scheduleRepository = ScheduleRepository();

  late final _tokenEvent = EBTokenEvent(
    ebTokenRepository: _ebTokenRepository,
    rootDelegate: _rootDelegate,
    loginDelegate: _loginDelegate,
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
        RepositoryProvider.value(value: homeDelegate),
        RepositoryProvider.value(value: _loadingDelegate),
        RepositoryProvider.value(value: _homeRepository),
        RepositoryProvider.value(value: _scheduleEvent),
        RepositoryProvider.value(value: _tokenEvent),
      ],
      child: const MockHomeBlocView(),
    );
  }
}

final class MockHomeBlocView extends StatelessWidget {
  const MockHomeBlocView({super.key});

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
          // )..add(OnAppearHomeView());
        );

        return bloc;
      },
      // child: MockHomeAppView(
      //   child: MockMiddleTransportView(),
      // ),
      child: const MockRegisterConfettiApp(),
    );
  }
}

final class MockHomeAppView extends StatelessWidget {
  final Widget child;

  const MockHomeAppView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WithRegisterConfettiView(
        child: MockHomeBlocView(),
      ),
    );
  }
}
