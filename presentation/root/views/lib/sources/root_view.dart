part of '../eb_root.dart';

final class RootView extends StatelessWidget {
  final EBAuthRepository _ebAuthRepository;
  final SearchPlaceDelegateForPlace _searchPlaceDelegateForPlace;
  final SearchPlaceDelegateForRoute _searchPlaceDelegateForRoute;
  final ScheduleRepository _scheduleRepository;
  final HomeDelegate _homeDelegate;
  // searchplace 좀더 하위뷰에서 주입하기..

  RootView({
    super.key,
    EBAuthRepository? ebAuthRepository,
    SearchPlaceDelegateForPlace? searchPlaceDelegateForPlace,
    SearchPlaceDelegateForRoute? searchPlaceDelegateForRoute,
    ScheduleRepository? scheduleRepository,
    HomeDelegate? homeDelegate,
  })  : _ebAuthRepository = ebAuthRepository ?? EBAuthRepository(),
        _searchPlaceDelegateForPlace =
            searchPlaceDelegateForPlace ?? SearchPlaceDelegateForPlace(),
        _searchPlaceDelegateForRoute =
            searchPlaceDelegateForRoute ?? SearchPlaceDelegateForRoute(),
        _scheduleRepository = scheduleRepository ?? ScheduleRepository(),
        _homeDelegate = homeDelegate ?? HomeDelegate();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _ebAuthRepository),
        RepositoryProvider.value(value: _searchPlaceDelegateForPlace),
        RepositoryProvider.value(value: _searchPlaceDelegateForRoute),
        RepositoryProvider.value(value: _scheduleRepository),
        RepositoryProvider.value(value: _homeDelegate),
      ],
      child: const _RootBlocView(),
    );
  }
}
