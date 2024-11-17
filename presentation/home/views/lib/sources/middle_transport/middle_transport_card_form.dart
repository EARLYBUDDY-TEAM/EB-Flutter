part of '../../eb_home.dart';

final class MiddleTransportCardForm extends StatelessWidget {
  final double horizontalPadding;
  final double verticalPadding;
  final Widget child;

  const MiddleTransportCardForm({
    super.key,
    required this.child,
    this.horizontalPadding = 20,
    this.verticalPadding = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: child,
      ),
    );
  }
}
