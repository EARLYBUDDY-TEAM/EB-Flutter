part of '../../eb_root.dart';

final class RootView extends StatelessWidget {
  final HomeDelegate _homeDelegate;
  final LoginDelegate _loginDelegate;
  final RootDelegate _rootDelegate;
  final LoadingDelegate _loadingDelegate;
  final AddScheduleDelegate _addScheduleDelegate;
  final FindRouteDelegate _findRouteDelegate;

  final EBAuthRepository _ebAuthRepository;
  final FindRouteRepository _findRouteRepository;
  final ScheduleRepository _scheduleRepository;
  final SearchPlaceRepository _searchPlaceRepository;
  final TokenRepository _tokenRepository;
  final HomeRepositoryAB _homeRepository;

  late final _tokenEvent = TokenEvent(
    rootDelegate: _rootDelegate,
    loginDelegate: _loginDelegate,
    tokenRepository: _tokenRepository,
  );
  late final _scheduleEvent = ScheduleEvent(
    loadingDelegate: _loadingDelegate,
    scheduleRepository: _scheduleRepository,
    tokenEvent: _tokenEvent,
  );
  late final _realTimeInfoEvent = RealTimeInfoEvent(
    homeRepositoryAB: _homeRepository,
  );
  // 좀더 하위뷰에서 주입하기..

  RootView({
    super.key,
    RootDelegate? rootDelegate,
    HomeDelegate? homeDelegate,
    LoginDelegate? loginDelegate,
    LoadingDelegate? loadingDelegate,
    AddScheduleDelegate? addScheduleDelegate,
    FindRouteDelegate? findRouteDelegate,
    EBAuthRepository? ebAuthRepository,
    FindRouteRepository? findRouteRepository,
    ScheduleRepository? scheduleRepository,
    SearchPlaceRepository? searchPlaceRepository,
    TokenRepository? tokenRepository,
    HomeRepositoryAB? homeRepository,
  })  : _homeDelegate = homeDelegate ?? HomeDelegate(),
        _loginDelegate = loginDelegate ?? LoginDelegate(),
        _rootDelegate = rootDelegate ?? RootDelegate(),
        _loadingDelegate = loadingDelegate ?? LoadingDelegate(),
        _addScheduleDelegate = addScheduleDelegate ?? AddScheduleDelegate(),
        _findRouteDelegate = findRouteDelegate ?? FindRouteDelegate(),
        _ebAuthRepository = ebAuthRepository ?? EBAuthRepository(),
        _findRouteRepository = findRouteRepository ?? FindRouteRepository(),
        _scheduleRepository = scheduleRepository ?? ScheduleRepository(),
        _searchPlaceRepository =
            searchPlaceRepository ?? SearchPlaceRepository(),
        _tokenRepository = tokenRepository ?? TokenRepository(),
        _homeRepository = homeRepository ?? HomeRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _rootDelegate),
        RepositoryProvider.value(value: _homeDelegate),
        RepositoryProvider.value(value: _loginDelegate),
        RepositoryProvider.value(value: _loadingDelegate),
        RepositoryProvider.value(value: _addScheduleDelegate),
        RepositoryProvider.value(value: _findRouteDelegate),
        RepositoryProvider.value(value: _ebAuthRepository),
        RepositoryProvider.value(value: _findRouteRepository),
        RepositoryProvider.value(value: _scheduleRepository),
        RepositoryProvider.value(value: _searchPlaceRepository),
        RepositoryProvider.value(value: _tokenRepository),
        RepositoryProvider.value(value: _homeRepository),
        RepositoryProvider.value(value: _tokenEvent),
        RepositoryProvider.value(value: _scheduleEvent),
        RepositoryProvider.value(value: _realTimeInfoEvent),
      ],
      child: const _RootBlocView(),
    );
  }
}
