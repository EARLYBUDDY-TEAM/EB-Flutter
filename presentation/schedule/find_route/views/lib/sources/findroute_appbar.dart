part of '../eb_find_route.dart';

final class _FindRouteAppBar extends AppBar {
  final String? parentName;
  final Function()? cancelAction;
  final Function()? backAction;

  final Color color = EBColors.blue1;
  final String fontFamily = FontFamily.nanumSquareBold;
  final double fontSize = 17;

  _FindRouteAppBar({
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
  double? get leadingWidth => 150; // dynamic하게 적용법?

  @override
  Widget? get leading => (parentName != null)
      ? NaviBackButton(
          parentViewName: parentName ?? '',
          onPressed: backAction,
        )
      : null;

  @override
  Widget? get title => Text(
        '경로 선택',
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
