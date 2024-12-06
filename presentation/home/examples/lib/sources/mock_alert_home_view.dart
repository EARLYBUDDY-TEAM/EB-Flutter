part of 'home_example.dart';

final homeDelegate = HomeDelegate();

final class _MockAlertHomeView extends StatelessWidget {
  final _loadingDelegate = LoadingDelegate();
  final _homeRepository = HomeRepository();
  late final _tokenEvent = TokenEvent(
    rootDelegate: RootDelegate(),
    loginDelegate: LoginDelegate(),
    tokenRepository: TokenRepository(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _loadingDelegate),
        RepositoryProvider.value(value: homeDelegate),
        RepositoryProvider.value(value: _homeRepository),
        RepositoryProvider.value(value: _tokenEvent),
      ],
      child: _MockAlertHomeViewApp(),
    );
  }
}

final class _MockAlertHomeViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: EBTheme().light(),
      home: const HomeView(),
    );
  }
}
