part of 'root_example.dart';

final class _MockAutoLoginView extends StatelessWidget {
  final _authRepository = EBAuthRepository();
  final _tokenRepository = TokenRepository();
  final _homeDelegate = HomeDelegate();
  final _rootDelegate = RootDelegate();

  _MockAutoLoginView();

  @override
  Widget build(BuildContext context) {
    return RootView(
      ebAuthRepository: _authRepository,
      tokenRepository: _tokenRepository,
      homeDelegate: _homeDelegate,
      rootDelegate: _rootDelegate,
    );
  }

  Future<void> setAutoLogin() async {
    final Result result = await _authRepository.logIn(
      email: 'abc@abc.com',
      password: 'abcd12',
    );

    switch (result) {
      case Success():
        final Token token = result.success.model;
        await _tokenRepository.saveToken(token);
        _homeDelegate.loginStatus.add(BaseStatus.success);
        _rootDelegate.authStatus.add(Authenticated());
      case Failure():
        log('login fail ...');
        return;
    }
  }
}