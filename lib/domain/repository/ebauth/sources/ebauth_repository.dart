import 'dart:async';
import 'dart:developer';
import 'package:earlybuddy/core/network/sources/endpoint/endpoint.dart';
import 'package:earlybuddy/core/network/sources/service/service.dart';
import 'package:earlybuddy/shared/eb_model/entity/entity.dart';

class EBAuthRepository {
  final controller = StreamController<AuthStatus>();
  final NetworkService service = NetworkService.shared;

  Stream<AuthStatus> get authInfo async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield UnAuthenticated();
    yield* controller.stream;
  }

  void dispose() => controller.close();

  Future<NetworkResult> logIn({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest.init(email: email, password: password);
    final result = await service.request(request);
    switch (result) {
      case (Success()):
        TokenDTO tokenDTO = result.model;
        final Token token = Token.fromDTO(tokenDTO: tokenDTO);
        return Success(model: token, statusCode: result.statusCode);
      case (Failure()):
        log(result.error.toString());
        return result;
    }
  }

  Future<int> register({
    required String email,
    required String password,
  }) async {
    final request = RegisterRequest.init(email: email, password: password);

    final result = await service.request(request);
    switch (result) {
      case (Success()):
        return result.statusCode;
      case (Failure()):
        log(result.error.toString());
        return result.statusCode;
    }
  }

  void addAuthenticate(Token token) {
    // save token
    controller.add(Authenticated(token: token));
  }

  void logOut() {
    controller.add(UnAuthenticated());
  }
}
