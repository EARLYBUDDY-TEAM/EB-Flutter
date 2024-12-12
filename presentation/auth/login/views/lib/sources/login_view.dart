part of '../eb_login.dart';

final class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute<void>(
      builder: (context) => const LoginView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authRepository: RepositoryProvider.of<EBAuthRepository>(context),
        tokenRepository: RepositoryProvider.of<TokenRepository>(context),
        rootDelegate: RepositoryProvider.of<RootDelegate>(context),
        homeDelegate: RepositoryProvider.of<HomeDelegate>(context),
        loginDelegate: RepositoryProvider.of<LoginDelegate>(context),
        loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
        secureStorage: RepositoryProvider.of<SecureStorage>(context),
      )..add(const SetAutoLogin()),
      // ),
      child: _LoginMultiBlocListener(),
    );
  }
}
