import 'dart:async';
import 'dart:developer';
import 'package:earlybuddy/domain/network/sources/endpoint/endpoint.dart';
import 'package:earlybuddy/domain/network/sources/service/service.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';

class EBAuthRepository {
  final _controller = StreamController<EBAuthInfo>();
  final NetworkService service = NetworkService.shared;

  Stream<EBAuthInfo> get authInfo async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield const EBAuthInfo.unAuth();
    yield* _controller.stream;
  }

  void dispose() => _controller.close();
}

extension AuthLogin on EBAuthRepository {
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest.init(email: email, password: password);
    final result = await service.request(request);
    TokenDTO tokenDTO;
    switch (result) {
      case (Success()):
        tokenDTO = result.dto;
      case (Failure()):
        return;
    }

    final EBToken token = EBToken.fromDTO(tokenDTO: tokenDTO);
    _controller.add(EBAuthInfo.auth(token));
    return;
  }

  void logOut() {
    _controller.add(const EBAuthInfo.unAuth());
  }
}

extension AuthRegister on EBAuthRepository {
  Future<bool> register({
    required String email,
    required String password,
  }) async {
    final request = RegisterRequest.init(email: email, password: password);

    final result = await service.request(request);
    switch (result) {
      case (Success()):
        return true;
      case (Failure()):
        return false;
    }
  }
}
