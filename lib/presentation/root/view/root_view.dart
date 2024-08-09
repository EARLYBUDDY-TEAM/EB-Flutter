import 'dart:developer';

import 'package:earlybuddy/domain/delegate/register.dart';
import 'package:earlybuddy/domain/repository/schedule/schedule_repository.dart';
import 'package:earlybuddy/presentation/root/bloc/bloc.dart';
import 'package:earlybuddy/domain/delegate/searchplace.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:earlybuddy/presentation/home/home.dart';
import 'package:earlybuddy/presentation/auth/login/login.dart';
import 'package:earlybuddy/presentation/auth/splash/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final class RootView extends StatelessWidget {
  final EBAuthRepository _ebAuthRepository;
  final SearchPlaceDelegateForPlace _searchPlaceDelegateForPlace;
  final SearchPlaceDelegateForRoute _searchPlaceDelegateForRoute;
  final ScheduleRepository _scheduleRepository;
  final RegisterDelegate _registerDelegate;
  // searchplace 좀더 하위뷰에서 주입하기..

  RootView({
    super.key,
    EBAuthRepository? ebAuthRepository,
    SearchPlaceDelegateForPlace? searchPlaceDelegateForPlace,
    SearchPlaceDelegateForRoute? searchPlaceDelegateForRoute,
    ScheduleRepository? scheduleRepository,
    RegisterDelegate? registerDelegate,
  })  : _ebAuthRepository = ebAuthRepository ?? EBAuthRepository(),
        _searchPlaceDelegateForPlace =
            searchPlaceDelegateForPlace ?? SearchPlaceDelegateForPlace(),
        _searchPlaceDelegateForRoute =
            searchPlaceDelegateForRoute ?? SearchPlaceDelegateForRoute(),
        _scheduleRepository = scheduleRepository ?? ScheduleRepository(),
        _registerDelegate = registerDelegate ?? RegisterDelegate();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _ebAuthRepository),
        RepositoryProvider.value(value: _searchPlaceDelegateForPlace),
        RepositoryProvider.value(value: _searchPlaceDelegateForRoute),
        RepositoryProvider.value(value: _scheduleRepository),
        RepositoryProvider.value(value: _registerDelegate),
      ],
      child: const _RootBlocView(),
    );
  }
}

final class _RootBlocView extends StatelessWidget {
  const _RootBlocView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootBloc(
        authRepository: RepositoryProvider.of<EBAuthRepository>(context),
      ),
      child: _RootNaviView(),
    );
  }
}

final class _RootNaviView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootNaviState();
}

final class _RootNaviState extends State<_RootNaviView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
      ],
      theme: EBTheme.light(),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<RootBloc, RootState>(
          listener: (context, state) {
            AuthStatus status = state.status;
            switch (status) {
              case Authenticated():
                log('nav route home view!!');
                _navigator.pushAndRemoveUntil(
                  HomeView.route(),
                  (route) => false,
                );
              case UnAuthenticated():
                log('nav route login view!!');
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
