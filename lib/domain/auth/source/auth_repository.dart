import 'dart:async';
import 'dart:developer';
import 'package:earlybuddy/core/network/endpoint/endpoint.dart';
import 'package:earlybuddy/core/network/network_service/network_service.dart';
import 'model/model.dart';

class AuthRepository {
  final _controller = StreamController<AuthInfo>();
  final NetworkService service = NetworkService();

  Stream<AuthInfo> get authInfo async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield const AuthInfo.unAuth();
    yield* _controller.stream;
  }

  void dispose() => _controller.close();
}

extension AuthLogin on AuthRepository {
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest.init(email: email, password: password);
    final TokenDTO tokenDTO = await service.request(request);
    final Token token = Token.fromDTO(tokenDTO: tokenDTO);
    _controller.add(AuthInfo.auth(token));
    log(token.toString());
    return;
  }

  void logOut() {
    _controller.add(const AuthInfo.unAuth());
  }
}

extension AuthRegister on AuthRepository {
  Future<bool> register({
    required String email,
    required String password,
  }) async {
    final request = RegisterRequest.init(email: email, password: password);

    try {
      EmptyDTO _ = await service.request(request);
      // _controller.add(AuthStatus.authenticated);
      return true;
    } catch (e) {
      // _controller.add(AuthStatus.unauthenticated);
      return false;
    }
  }
}
