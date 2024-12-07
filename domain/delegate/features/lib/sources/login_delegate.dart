part of '../eb_delegate.dart';

final class LoginDelegate {
  final tokenStatus = BehaviorSubject<BaseStatus>.seeded(BaseStatus.init);
  final completeLogout = BehaviorSubject<BaseStatus>.seeded(BaseStatus.init);

  Future<void> dispose() async {
    await tokenStatus.close();
    await completeLogout.close();
  }
}
