part of 'root_example.dart';

final class _MockAutoLoginView extends StatelessWidget {
  final _authRepository = EBAuthRepository();
  final _loginDelegate = LoginDelegate();

  _MockAutoLoginView();

  @override
  Widget build(BuildContext context) {
    return RootView(
      ebAuthRepository: _authRepository,
      loginDelegate: _loginDelegate,
    );
  }

  // bloc, event 사용하는거는??
  Future<void> setAutoLogin() async {
    final Result result = await _authRepository.logIn(
      email: 'abc@abc.com',
      password: 'abcd12',
    );

    switch (result) {
      case Success():
        final Token token = result.success.model;
        _loginDelegate.setLoginSuccess();
        await _authRepository.addAuthenticate(token);
      case Failure():
        log('login fail ...');
        return;
    }
  }
}
