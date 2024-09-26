part of '../../eb_root.dart';

final class _RootBlocView extends StatelessWidget {
  const _RootBlocView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootBloc(
        rootDelegate: RepositoryProvider.of<RootDelegate>(context),
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
                _navigator.pushAndRemoveUntil(
                  HomeView.route(),
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
      onGenerateRoute: (_) => LoginView.route(),
    );
  }
}
