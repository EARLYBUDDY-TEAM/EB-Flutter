part of '../../eb_uikit.dart';

final class LoadingDelegate {
  final _overlaySubject = PublishSubject<bool>();

  Stream<bool> get stream async* {
    await for (final isOverlay in _overlaySubject) {
      if (isOverlay == false) {
        await Future.delayed(const Duration(milliseconds: 300));
      }
      yield isOverlay;
    }
  }

  void set() {
    _overlaySubject.add(true);
  }

  void dismiss() {
    _overlaySubject.add(false);
  }
}
