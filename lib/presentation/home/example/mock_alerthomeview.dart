part of 'home_example.dart';

final class _MockAlertHomeView extends StatelessWidget {
  final RegisterDelegate _registerDelegate =
      RegisterDelegate(isFirstLogin: false);
  final LoginDelegate _loginDelegate = LoginDelegate(isSuccess: true);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _registerDelegate),
        RepositoryProvider.value(value: _loginDelegate),
      ],
      child: const HomeView(),
    );
  }
}
