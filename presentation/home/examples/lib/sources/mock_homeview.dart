part of 'home_example.dart';

final homeDelegate = HomeDelegate();

final class _MockAlertHomeView extends StatelessWidget {
  final _ebAuthRepository = EBAuthRepository();
  final _homeDelegate = HomeDelegate();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _ebAuthRepository),
        RepositoryProvider.value(value: _homeDelegate),
      ],
      child: _MockAlertHomeViewApp(),
    );
  }
}

final class _MockAlertHomeViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: EBTheme.light(),
      home: const HomeView(),
    );
  }
}
