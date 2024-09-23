part of '../eb_root.dart';

final class RootView extends StatelessWidget {
  final EBAuthRepository _ebAuthRepository;
  final ScheduleRepository _scheduleRepository;

  final SearchPlaceDelegateForPlace _searchPlaceDelegateForPlace;
  final SearchPlaceDelegateForRoute _searchPlaceDelegateForRoute;
  final HomeDelegate _homeDelegate;
  final LoginDelegate _loginDelegate;
  // searchplace 좀더 하위뷰에서 주입하기..

  RootView({
    super.key,
    EBAuthRepository? ebAuthRepository,
    SearchPlaceDelegateForPlace? searchPlaceDelegateForPlace,
    SearchPlaceDelegateForRoute? searchPlaceDelegateForRoute,
    ScheduleRepository? scheduleRepository,
    HomeDelegate? homeDelegate,
    LoginDelegate? loginDelegate,
  })  : _ebAuthRepository = ebAuthRepository ?? EBAuthRepository(),
        _searchPlaceDelegateForPlace =
            searchPlaceDelegateForPlace ?? SearchPlaceDelegateForPlace(),
        _searchPlaceDelegateForRoute =
            searchPlaceDelegateForRoute ?? SearchPlaceDelegateForRoute(),
        _scheduleRepository = scheduleRepository ?? ScheduleRepository(),
        _homeDelegate = homeDelegate ?? HomeDelegate(),
        _loginDelegate = loginDelegate ?? LoginDelegate();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _ebAuthRepository),
        RepositoryProvider.value(value: _searchPlaceDelegateForPlace),
        RepositoryProvider.value(value: _searchPlaceDelegateForRoute),
        RepositoryProvider.value(value: _scheduleRepository),
        RepositoryProvider.value(value: _homeDelegate),
        RepositoryProvider.value(value: _loginDelegate),
      ],
      child: const _RootBlocView(),
    );
  }
}
