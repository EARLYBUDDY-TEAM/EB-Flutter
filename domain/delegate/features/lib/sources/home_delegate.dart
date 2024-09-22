part of '../eb_delegate.dart';

final class HomeDelegate {
  final loginStatusController = StreamController<BaseStatus>();

  Stream<BaseStatus> get loginStatus async* {
    yield BaseStatus.init;
    yield* loginStatusController.stream;
  }

  final registerStatusController = StreamController<BaseStatus>();

  Stream<BaseStatus> get registerStatus async* {
    yield BaseStatus.init;
    yield* registerStatusController.stream;
  }

  void dispose() {
    loginStatusController.close();
    registerStatusController.close();
  }
}
