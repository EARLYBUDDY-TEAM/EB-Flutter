part of '../eb_uikit.dart';

final class EBSnackBar extends SnackBar {
  EBSnackBar({super.key, required String text})
      : super(
          content: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: NanumSquare.extraBold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        );

  @override
  Color? get backgroundColor => EBColors.blue3;
}
