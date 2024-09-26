part of '../../eb_root.dart';

final class RootView extends StatelessWidget {
  final SearchPlaceDelegateForPlace _searchPlaceDelegateForPlace;
  final SearchPlaceDelegateForRoute _searchPlaceDelegateForRoute;
  final HomeDelegate _homeDelegate;
  final LoginDelegate _loginDelegate;
  final RootDelegate _rootDelegate;

  final EBAuthRepository _ebAuthRepository;
  final FindRouteRepository _findRouteRepository;
  final ScheduleRepository _scheduleRepository;
  final SearchPlaceRepository _searchPlaceRepository;
  final TokenRepository _tokenRepository;
  // 좀더 하위뷰에서 주입하기..

  RootView({
    super.key,
    SearchPlaceDelegateForPlace? searchPlaceDelegateForPlace,
    SearchPlaceDelegateForRoute? searchPlaceDelegateForRoute,
    RootDelegate? rootDelegate,
    HomeDelegate? homeDelegate,
    LoginDelegate? loginDelegate,
    EBAuthRepository? ebAuthRepository,
    FindRouteRepository? findRouteRepository,
    ScheduleRepository? scheduleRepository,
    SearchPlaceRepository? searchPlaceRepository,
    TokenRepository? tokenRepository,
  })  : _searchPlaceDelegateForPlace =
            searchPlaceDelegateForPlace ?? SearchPlaceDelegateForPlace(),
        _searchPlaceDelegateForRoute =
            searchPlaceDelegateForRoute ?? SearchPlaceDelegateForRoute(),
        _homeDelegate = homeDelegate ?? HomeDelegate(),
        _loginDelegate = loginDelegate ?? LoginDelegate(),
        _rootDelegate = rootDelegate ?? RootDelegate(),
        _ebAuthRepository = ebAuthRepository ?? EBAuthRepository(),
        _findRouteRepository = findRouteRepository ?? FindRouteRepository(),
        _scheduleRepository = scheduleRepository ?? ScheduleRepository(),
        _searchPlaceRepository =
            searchPlaceRepository ?? SearchPlaceRepository(),
        _tokenRepository = tokenRepository ?? TokenRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _searchPlaceDelegateForPlace),
        RepositoryProvider.value(value: _searchPlaceDelegateForRoute),
        RepositoryProvider.value(value: _rootDelegate),
        RepositoryProvider.value(value: _homeDelegate),
        RepositoryProvider.value(value: _loginDelegate),
        RepositoryProvider.value(value: _ebAuthRepository),
        RepositoryProvider.value(value: _findRouteRepository),
        RepositoryProvider.value(value: _scheduleRepository),
        RepositoryProvider.value(value: _searchPlaceRepository),
        RepositoryProvider.value(value: _tokenRepository),
      ],
      child: const _RootBlocView(),
    );
  }
}
