part of '../eb_delegate.dart';

final class RootDelegate {
  final authStatus = PublishSubject<AuthStatus>();

  Future<void> dispose() async {
    await authStatus.close();
  }
}
