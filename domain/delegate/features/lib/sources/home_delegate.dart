part of '../eb_delegate.dart';

final class HomeDelegate {
  final loginStatus = BehaviorSubject<BaseStatus>.seeded(BaseStatus.init);
  final registerStatus = BehaviorSubject<BaseStatus>.seeded(BaseStatus.init);
  // final registerStatus = PublishSubject<BaseStatus>();

  Future<void> dispose() async {
    await loginStatus.close();
    await registerStatus.close();
  }
}
