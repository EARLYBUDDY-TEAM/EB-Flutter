part of '../../eb_root.dart';

final class RootAutoLoginView extends StatelessWidget {
  final _authRepository = EBAuthRepository();
  final _tokenRepository = TokenRepository(
    secureStorage: SecureStorage(),
    networkService: NetworkService(),
  );
  final _homeDelegate = HomeDelegate();
  final _rootDelegate = RootDelegate();

  RootAutoLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return RootView(
      ebAuthRepository: _authRepository,
      homeDelegate: _homeDelegate,
      rootDelegate: _rootDelegate,
    );
  }

  Future<void> setAutoLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    final email = ENV_TESTUSER.email;
    final password = ENV_TESTUSER.password;

    final NetworkResponse<Token> result = await _authRepository.logIn(
      email: email,
      password: password,
    );

    switch (result) {
      case SuccessResponse():
        final Token token = result.model;
        await _tokenRepository.saveToken(token);
        _homeDelegate.loginStatus.add(BaseStatus.success);
        _rootDelegate.authStatus.add(Authenticated());
      case FailureResponse():
        log('login fail ...');
        return;
    }
  }
}

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
  late final _tokenRepository = TokenRepository(
    secureStorage: _secureStorage,
    networkService: _networkService,
  );
  final HomeRepositoryAB _homeRepository;

  final SecureStorage _secureStorage;
  final NetworkService _networkService;

  late final _tokenEvent = TokenEvent(
    rootDelegate: _rootDelegate,
    loginDelegate: _loginDelegate,
    tokenRepository: _tokenRepository,
    secureStorage: _secureStorage,
  );
  late final _scheduleEvent = ScheduleEvent(
    loadingDelegate: _loadingDelegate,
    scheduleRepository: _scheduleRepository,
    tokenEvent: _tokenEvent,
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
    HomeRepositoryAB? homeRepository,
    SecureStorage? secureStorage,
    NetworkService? networkService,
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
        _homeRepository = homeRepository ?? HomeRepository(),
        _secureStorage = secureStorage ?? SecureStorage(),
        _networkService = networkService ?? NetworkService();

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
        RepositoryProvider.value(value: _secureStorage),
      ],
      child: const _RootBlocView(),
    );
  }
}
