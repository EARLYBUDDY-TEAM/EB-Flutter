part of '../eb_delegate.dart';

final class HomeDelegate {
  final loginStatus = BehaviorSubject<BaseStatus>.seeded(BaseStatus.init);
  final registerStatus = BehaviorSubject<BaseStatus>.seeded(BaseStatus.init);
  final getAllSchedules = PublishSubject<void>();
  final cancelModalView = PublishSubject<void>();

  Future<void> dispose() async {
    await loginStatus.close();
    await registerStatus.close();
    await getAllSchedules.close();
    await cancelModalView.close();
  }
}
