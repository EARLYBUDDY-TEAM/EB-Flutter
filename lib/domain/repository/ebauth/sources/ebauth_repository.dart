import 'dart:async';
import 'dart:developer';
import 'package:earlybuddy/domain/network/sources/endpoint/endpoint.dart';
import 'package:earlybuddy/domain/network/sources/service/service.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';

class EBAuthRepository {
  final controller = StreamController<AuthStatus>();
  final NetworkService service = NetworkService.shared;

  Stream<AuthStatus> get authInfo async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield UnAuthenticated();
    yield* controller.stream;
  }

  void dispose() => controller.close();
}

extension AuthLogin on EBAuthRepository {
  Future<int> logIn({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest.init(email: email, password: password);
    final result = await service.request(request);
    TokenDTO tokenDTO;
    switch (result) {
      case (Success()):
        log('login request success : ${result.dto.toString()}');
        tokenDTO = result.dto;
      case (Failure()):
        log('login fail, statusCode : ${result.statusCode}');
        return result.statusCode;
    }

    final Token token = Token.fromDTO(tokenDTO: tokenDTO);
    controller.add(Authenticated(token: token));
    return result.statusCode;
  }

  void logOut() {
    controller.add(UnAuthenticated());
  }
}

extension AuthRegister on EBAuthRepository {
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
        return result.statusCode;
    }
  }
}
