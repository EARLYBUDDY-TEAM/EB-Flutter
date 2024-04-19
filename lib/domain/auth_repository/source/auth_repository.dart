import 'dart:async';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () {
        _controller.add(AuthStatus.authenticated);
      },
    );
  }

  void logOut() {
    _controller.add(AuthStatus.unauthenticated);
  }

  Future<void> Register({
    required String email,
    required String password,
  }) async {}

  void dispose() => _controller.close();
}
