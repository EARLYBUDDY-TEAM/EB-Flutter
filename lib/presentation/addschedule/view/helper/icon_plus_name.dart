part of '../view.dart';

final class _IconPlusName extends StatelessWidget {
  final String name;
  final IconData iconData;
  final double fontSize;
  bool isActive;

  _IconPlusName({
    required this.name,
    required this.iconData,
    required this.fontSize,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 30,
          color: isActive ? EBColors.blue3 : EBColors.inactive,
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: TextStyle(
            fontFamily: NanumSquare.bold,
            fontSize: fontSize,
            color: isActive ? EBColors.text : EBColors.inactive,
          ),
        ),
      ],
    );
  }
}
