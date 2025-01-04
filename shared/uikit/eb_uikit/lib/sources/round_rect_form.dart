part of '../eb_uikit.dart';

class RoundRectForm extends StatelessWidget {
  final Widget? child;
  final double _borderRadius;

  const RoundRectForm({
    super.key,
    this.child,
    double? borderRadius,
  }) : _borderRadius = borderRadius ?? 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 6,
          ),
        ],
      ),
      child: child,
    );
  }
}
