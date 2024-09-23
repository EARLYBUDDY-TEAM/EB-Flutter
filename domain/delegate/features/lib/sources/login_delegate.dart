part of '../eb_delegate.dart';

final class LoginDelegate {
  final tokenStatusController = StreamController<BaseStatus>.broadcast();

  Stream<BaseStatus> get tokenStatus async* {
    yield BaseStatus.init;
    yield* tokenStatusController.stream;
  }

  void dispose() {
    tokenStatusController.close();
  }
}
