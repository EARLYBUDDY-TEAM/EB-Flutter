part of 'root_example.dart';

final class _MockAutoLoginRootView extends StatelessWidget {
  final _authRepository = EBAuthRepository();
  final _loginDelegate = LoginDelegate();

  _MockAutoLoginRootView();

  @override
  Widget build(BuildContext context) {
    return RootView(
      ebAuthRepository: _authRepository,
      loginDelegate: _loginDelegate,
    );
  }

  Future<void> setAutoLogin() async {
    final NetworkResult result = await _authRepository.logIn(
      email: 'abc@abc.com',
      password: 'abcd12',
    );

    switch (result) {
      case Success():
        final Token token = result.model;
        _loginDelegate.setLoginSuccess();
        _authRepository.addAuthenticate(token);
      case Failure():
        log('login fail ...');
        return;
    }
  }
}

//   Future<void> mockLogin() async {
//     await Future<void>.delayed(const Duration(seconds: 3));
//     final NetworkResult result =
//         await logIn(email: 'abc@abc.com', password: 'abcd12');

//     switch (result) {
//       case Success():
//         final Token token = result.model;
//         addAuthenticate(token);
//       case Failure():
//         log('login fail ...');
//     }
//   }


// Future<void> initRootExample() async {
//   final mockEBAuthRepository = MockEBAuthRepository();
//   final rootExample = RootExample(mockEBAuthRepository: mockEBAuthRepository);
//   runApp(rootExample);
//   await mockEBAuthRepository.mockLogin();
// }
