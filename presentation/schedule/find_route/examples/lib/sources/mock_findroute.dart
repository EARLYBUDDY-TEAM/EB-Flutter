part of 'findroute_example.dart';

final class _MockFindRouteView extends StatelessWidget {
  final MaterialPageRoute mockFindRouteView;

  final loadingDelegate = LoadingDelegate();
  final findRouteDelegate = FindRouteDelegate();
  final addScheduleDelegate = AddScheduleDelegate();
  final homeDelegate = HomeDelegate();
  final findRouteRepository = FindRouteRepository();
  final scheduleRepository = ScheduleRepository();
  late final tokenEvent = TokenEvent(
    loginDelegate: LoginDelegate(),
    rootDelegate: RootDelegate(),
    tokenRepository: TokenRepository(),
  );
  late final scheduleEvent = ScheduleEvent(
    loadingDelegate: loadingDelegate,
    scheduleRepository: scheduleRepository,
    tokenEvent: tokenEvent,
  );

  _MockFindRouteView({super.key, required this.mockFindRouteView});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: loadingDelegate),
        RepositoryProvider.value(value: addScheduleDelegate),
        RepositoryProvider.value(value: homeDelegate),
        RepositoryProvider.value(value: findRouteDelegate),
        RepositoryProvider.value(value: findRouteRepository),
      ],
      child: MockModalBottomSheetButton(modalView: mockFindRouteView),
    );
  }

  static _MockFindRouteView empty(BuildContext context) {
    final view = _MockFindRouteBlocView(
      setting: makeReadSetting(context: context),
      contentStatus: EmptyDataFindRouteStatus(),
    );

    final route = makeRoute(view: view);

    return _MockFindRouteView(mockFindRouteView: route(context));
  }

  static _MockFindRouteView read(BuildContext context) {
    final view = _MockFindRouteBlocView(
      setting: makeReadSetting(context: context, subPaths: mockSubPaths),
      contentStatus:
          DetailFindRouteStatus(selectedIndex: 0, subPaths: mockSubPaths),
    );

    final route = makeRoute(view: view);

    return _MockFindRouteView(mockFindRouteView: route(context));
  }
}

final class _MockFindRouteBlocView extends StatelessWidget {
  final startPlace = Place.mockStart();
  final endPlace = Place.mockEnd();
  final SealedFindRouteSetting setting;
  final SealedFindRouteContentStatus contentStatus;
  final String? parentName;

  _MockFindRouteBlocView({
    super.key,
    required this.setting,
    required this.contentStatus,
    this.parentName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FindRouteBloc(
        scheduleEvent: RepositoryProvider.of<ScheduleEvent>(context),
        loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
        findRouteDelegate: RepositoryProvider.of<FindRouteDelegate>(context),
        addScheduleDelegate:
            RepositoryProvider.of<AddScheduleDelegate>(context),
        homeDelegate: RepositoryProvider.of<HomeDelegate>(context),
        findRouteRepository:
            RepositoryProvider.of<FindRouteRepository>(context),
        findRouteState: FindRouteState(
          searchPlaceInfo: SearchPlaceInfo(
            startPlace: startPlace,
            endPlace: endPlace,
          ),
          setting: setting,
        ),
      )..add(SetupFindRouteView(setting: setting)),
      // )..add(SetFindRouteContentStatus(contentStatus: contentStatus)),
      child: FindRouteScaffold(
        parentName: parentName,
      ),
    );
  }
}
