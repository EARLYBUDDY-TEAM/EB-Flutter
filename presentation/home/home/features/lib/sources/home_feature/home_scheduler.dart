part of '../../home_feature.dart';

final class HomeScheduler {
  StreamSubscription<dynamic>? _timerSubscription;
  final int reloadLoopMin = 1;

  Future<void> tearDown() async {
    await _timerSubscription?.cancel().then((_) {
      _timerSubscription = null;
    });
  }

  void start({
    required Function() action,
  }) {
    _timerSubscription =
        Stream.periodic(Duration(minutes: reloadLoopMin)).listen((_) {
      action();
    });
  }
}
