part of '../eb_delegate.dart';

final class RootDelegate {
  final authStatus = BehaviorSubject<AuthStatus>.seeded(UnAuthenticated());

  Future<void> dispose() async {
    await authStatus.close();
  }
}
