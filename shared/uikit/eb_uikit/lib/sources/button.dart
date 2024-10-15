part of '../eb_uikit.dart';

class EBButton extends StatelessWidget {
  final String name;
  final VoidCallback? onPressed;

  const EBButton({
    super.key,
    required this.name,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.grey,
        disabledForegroundColor: Colors.white,
        backgroundColor: EBColors.blue3,
        foregroundColor: Colors.white,
        shadowColor: Colors.black87,
        textStyle: const TextStyle(
          fontFamily: FontFamily.nanumSquareBold,
          fontSize: 20,
        ),
        padding: const EdgeInsets.all(10),
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(name),
    );
  }
}

class EBRoundedButton extends StatelessWidget {
  final String text;
  final double? height;
  final double fontSize;
  final Color color;
  final Function()? onPressed;

  const EBRoundedButton({
    super.key,
    required this.text,
    this.height,
    this.fontSize = 14,
    this.color = Colors.grey,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: Size.zero,
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          side: BorderSide(
            width: 1,
            color: color,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            color: color,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
