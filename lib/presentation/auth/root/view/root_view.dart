import 'package:earlybuddy/presentation/auth/root/bloc/bloc.dart';
import 'package:earlybuddy/domain/delegate/searchplace.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/presentation/schedule/addschedule/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:earlybuddy/presentation/home/home.dart';
import 'package:earlybuddy/presentation/auth/login/login.dart';
import 'package:earlybuddy/presentation/auth/splash/splash.dart';

final class RootView extends StatelessWidget {
  final EBAuthRepository _ebAuthRepository;
  final SearchPlaceDelegateForPlace _searchPlaceDelegateForPlace;
  final SearchPlaceDelegateForRoute _searchPlaceDelegateForRoute;
  // searchplace 좀더 하위뷰에서 주입하기..

  RootView({
    super.key,
    EBAuthRepository? ebAuthRepository,
    SearchPlaceDelegateForPlace? searchPlaceDelegateForPlace,
    SearchPlaceDelegateForRoute? searchPlaceDelegateForRoute,
  })  : _ebAuthRepository = ebAuthRepository ?? EBAuthRepository(),
        _searchPlaceDelegateForPlace =
            searchPlaceDelegateForPlace ?? SearchPlaceDelegateForPlace(),
        _searchPlaceDelegateForRoute =
            searchPlaceDelegateForRoute ?? SearchPlaceDelegateForRoute();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _ebAuthRepository),
        RepositoryProvider.value(value: _searchPlaceDelegateForPlace),
        RepositoryProvider.value(value: _searchPlaceDelegateForRoute),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RootBloc(
              authRepository: _ebAuthRepository,
            ),
          ),
          BlocProvider(
            create: (context) => AddScheduleBloc(
              searchPlaceDelegateForPlace: _searchPlaceDelegateForPlace,
              searchPlaceDelegateForRoute: _searchPlaceDelegateForRoute,
            ),
          ),
        ],
        child: RootNaviView(),
      ),
    );
  }
}

final class RootNaviView extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  RootNaviView({super.key});

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<RootBloc, RootState>(
          listener: (context, state) {
            switch (state.status) {
              case Authenticated():
                _navigator.pushAndRemoveUntil<void>(
                  EBHomeView.route(),
                  (route) => false,
                );
              case UnAuthenticated():
                _navigator.pushAndRemoveUntil(
                  LoginView.route(),
                  (route) => false,
                );
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashView.route(),
    );
  }
}
