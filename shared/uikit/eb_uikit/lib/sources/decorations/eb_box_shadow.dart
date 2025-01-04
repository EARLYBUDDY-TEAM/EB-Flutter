part of '../../eb_uikit.dart';

final class EBBoxShadow {
  static BoxShadow init() {
    return BoxShadow(
      color: Colors.grey.shade300.withOpacity(0.3),
      spreadRadius: 3,
      blurRadius: 6,
    );
  }
}
