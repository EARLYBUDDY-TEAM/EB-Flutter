import 'package:earlybuddy/app/app/bloc/ebauth_bloc.dart';
import 'package:earlybuddy/domain/delegate/searchplace.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/presentation/schedule/addschedule/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:earlybuddy/presentation/home/home.dart';
import 'package:earlybuddy/presentation/auth/login/login.dart';
import 'package:earlybuddy/presentation/auth/splash/splash.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  late final EBAuthRepository _authRepository;
  late final SearchPlaceDelegateForPlace _searchPlaceDelegateForPlace;
  late final SearchPlaceDelegateForRoute _searchPlaceDelegateForRoute;

  @override
  void initState() {
    super.initState();
    _authRepository = EBAuthRepository();
    _searchPlaceDelegateForPlace = SearchPlaceDelegateForPlace();
    _searchPlaceDelegateForRoute = SearchPlaceDelegateForRoute();
  }

  @override
  void dispose() {
    _authRepository.dispose();
    _searchPlaceDelegateForPlace.dispose();
    _searchPlaceDelegateForRoute.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _searchPlaceDelegateForPlace),
        RepositoryProvider.value(value: _searchPlaceDelegateForRoute),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => EBAuthBloc(authRepository: _authRepository),
          ),
          BlocProvider(
            create: (context) => AddScheduleBloc(
              searchPlaceDelegateForPlace: _searchPlaceDelegateForPlace,
              searchPlaceDelegateForRoute: _searchPlaceDelegateForRoute,
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<StatefulWidget> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<EBAuthBloc, EBAuthState>(
          listener: (context, state) {
            switch (state.status) {
              case EBAuthStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomeView.route(),
                  (route) => false,
                );
              case EBAuthStatus.unauthenticated:
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
