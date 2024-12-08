part of '../../eb_root.dart';

final class _RootBlocView extends StatelessWidget {
  const _RootBlocView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RootBloc>(
          create: (context) => RootBloc(
            rootDelegate: RepositoryProvider.of<RootDelegate>(context),
          ),
        ),
        BlocProvider<MenuBloc>(
          create: (context) => MenuBloc(
            loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
            rootDelegate: RepositoryProvider.of<RootDelegate>(context),
            loginDelegate: RepositoryProvider.of<LoginDelegate>(context),
          ),
        ),
      ],
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
      ],
      theme: EBTheme().light(),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return WithLoadingView(
          loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
          child: BlocListener<RootBloc, RootState>(
            listener: (context, state) {
              AuthStatus status = state.status;
              switch (status) {
                case Authenticated():
                  _navigator.pushAndRemoveUntil(
                    HomeView.route(context),
                    (route) => false,
                  );
                case UnAuthenticated():
                  _navigator.pushAndRemoveUntil(
                    LoginView.route(context),
                    (route) => false,
                  );
              }
            },
            child: child,
          ),
        );
      },
      onGenerateRoute: (_) => LoginView.route(context),
    );
  }
}
