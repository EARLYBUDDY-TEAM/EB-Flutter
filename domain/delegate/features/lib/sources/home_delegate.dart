part of '../eb_delegate.dart';

final class HomeDelegate {
  final loginStatusController = StreamController<BaseStatus>();

  Stream<BaseStatus> get loginStatus async* {
    // await Future<void>.delayed(const Duration(seconds: 1));
    yield BaseStatus.init;
    yield* loginStatusController.stream;
  }

  void dispose() {
    loginStatusController.close();
  }
}
