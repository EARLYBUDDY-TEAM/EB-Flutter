part of '../eb_find_route.dart';

final class _FindRouteAppBar extends AppBar {
  final String titleText;
  final String? parentName;
  final Function()? cancelAction;
  final Function()? backAction;

  final Color color = EBColors.blue1;
  final String fontFamily = FontFamily.nanumSquareBold;
  final double fontSize = 17;

  _FindRouteAppBar({
    required this.titleText,
    this.parentName,
    this.backAction,
    this.cancelAction,
  });

  @override
  Color? get backgroundColor => Colors.white;
  @override
  double? get scrolledUnderElevation => 0;
  @override
  bool get automaticallyImplyLeading => false;
  @override
  double? get leadingWidth => 120; // dynamic하게 적용법?

  @override
  Widget? get leading => (parentName != null)
      ? NaviBackButton(
          parentViewName: parentName ?? '',
          onPressed: backAction,
        )
      : null;

  @override
  Widget? get title => Text(
        titleText,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          fontFamily: fontFamily,
        ),
      );

  @override
  List<Widget>? get actions => List<Widget>.of([
        TextButton(
          onPressed: cancelAction,
          child: Text(
            '취소',
            style: TextStyle(
              color: color,
              fontFamily: fontFamily,
              fontSize: fontSize,
            ),
          ),
        )
      ]);
}
