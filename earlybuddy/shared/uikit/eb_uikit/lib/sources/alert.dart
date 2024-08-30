part of '../eb_uikit.dart';

final class EBAlert {
  static void showModalPopup({
    required BuildContext context,
    String? title,
    String? content,
    List<Widget>? actions,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: _titleWidget(title),
        content: _contentWidget(content),
        actions: actions ?? [],
      ),
    );
  }

  static Widget? _titleWidget(String? title) {
    return title == null
        ? null
        : Text(
            title,
            style: TextStyle(
              fontFamily: FontFamily.nanumSquareExtraBold,
              color: EBColors.text,
            ),
          );
  }

  static Widget? _contentWidget(String? content) {
    return content == null
        ? null
        : Text(
            content,
            style: TextStyle(
              fontFamily: FontFamily.nanumSquareBold,
              color: EBColors.text,
            ),
          );
  }

  static CupertinoDialogAction makeAction({
    required String name,
    void Function()? onPressed,
    bool? isDefaultAction,
    bool? isDestructiveAction,
  }) {
    return CupertinoDialogAction(
      isDefaultAction: isDefaultAction ?? false,
      isDestructiveAction: isDestructiveAction ?? false,
      onPressed: onPressed,
      textStyle: TextStyle(
        fontFamily: FontFamily.nanumSquareBold,
        color: EBColors.blue1,
      ),
      child: Text(name),
    );
  }
}
