import 'dart:async';
import 'package:earlybuddy/core/network/endpoint/endpoint.dart';
import 'package:earlybuddy/core/network/network_service/network_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  void dispose() => _controller.close();
}

extension Login on AuthRepository {
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
}

extension Register on AuthRepository {
  Future<bool> register({
    required String email,
    required String password,
  }) async {
    var service = NetworkService();
    var request = EBApiRequest.register(email: email, password: password);

    try {
      EmptyDTO _ = await service.request(request);
      _controller.add(AuthStatus.authenticated);
      return true;
    } catch (e) {
      _controller.add(AuthStatus.unauthenticated);
      return false;
    }
  }
}
