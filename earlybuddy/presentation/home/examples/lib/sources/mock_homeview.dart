part of 'home_example.dart';

final class _MockAlertHomeView extends StatelessWidget {
  // final _registerDelegate = RegisterDelegate(isFirstLogin: false);
  // final _loginDelegate = LoginDelegate(isSuccess: true);
  final _registerDelegate = RegisterDelegate(isFirstLogin: true);
  final _loginDelegate = LoginDelegate(isSuccess: true);
  final _ebAuthRepository = EBAuthRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _registerDelegate),
        RepositoryProvider.value(value: _loginDelegate),
        RepositoryProvider.value(value: _ebAuthRepository),
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
