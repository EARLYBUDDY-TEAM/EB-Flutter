part of '../../home_feature.dart';

final class HomeScheduler {
  final Function() action;

  StreamSubscription<dynamic>? _timerSubscription;
  final int reloadLoopMin = 1;

  HomeScheduler({
    required this.action,
  });

  void start() {
    _timerSubscription =
        // Stream.periodic(Duration(minutes: reloadLoopMin)).listen((_) {
        Stream.periodic(const Duration(seconds: 10)).listen((_) {
      action();
    });
  }
}
