part of '../eb_uikit.dart';

final class ScreenSize {
  static final safeArea = ScreenSafeArea();

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

final class ScreenSafeArea {
  double bottom(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  double top(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
}
