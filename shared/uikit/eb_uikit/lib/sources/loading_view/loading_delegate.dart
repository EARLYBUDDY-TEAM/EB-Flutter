part of '../../eb_uikit.dart';

final class LoadingDelegate {
  final stream = PublishSubject<bool>();

  void set() {
    stream.add(true);
  }

  void dismiss() {
    stream.add(false);
  }
}
