import 'dart:async';
import 'package:earlybuddy/domain/network/sources/endpoint/endpoint.dart';
import 'package:earlybuddy/domain/network/sources/network_service/network_service.dart';
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
    final TokenDTO tokenDTO = await service.request(request);
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

    try {
      EmptyDTO _ = await service.request(request);
      await logIn(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }
}
