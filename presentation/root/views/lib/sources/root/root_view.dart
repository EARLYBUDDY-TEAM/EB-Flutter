part of '../../eb_root.dart';

final class RootAutoLoginView extends StatelessWidget {
  final _authRepository = EBAuthRepository();
  final _secureStorage = SecureStorage();
  late final _tokenRepository = EBTokenRepository(
    secureStorage: _secureStorage,
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

    final fcmToken = await NotificationManager.getFCMToken() ?? '';
    final NetworkResponse<LoginResult> result = await _authRepository.logIn(
      email: email,
      password: password,
      fcmToken: fcmToken,
    );

    switch (result) {
      case SuccessResponse():
        final Token token = result.model.token;
        await _tokenRepository.saveToken(token);
        await _secureStorage.write(
          key: SecureStorageKey.nickName,
          value: result.model.nickName,
        );

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
  final FCMTokenRepository _fcmTokenRepository;
  final EBTokenRepository _ebTokenRepository;
  final HomeRepositoryAB _homeRepository;

  late final _tokenEvent = EBTokenEvent(
    rootDelegate: _rootDelegate,
    loginDelegate: _loginDelegate,
    ebTokenRepository: _ebTokenRepository,
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
    FCMTokenRepository? fcmTokenRepository,
    EBTokenRepository? ebTokenRepository,
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
        _fcmTokenRepository = fcmTokenRepository ?? FCMTokenRepository(),
        _ebTokenRepository = ebTokenRepository ?? EBTokenRepository();

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
        RepositoryProvider.value(value: _ebTokenRepository),
        RepositoryProvider.value(value: _fcmTokenRepository),
        RepositoryProvider.value(value: _homeRepository),
        RepositoryProvider.value(value: _tokenEvent),
        RepositoryProvider.value(value: _scheduleEvent),
      ],
      child: const _RootBlocView(),
    );
  }
}
