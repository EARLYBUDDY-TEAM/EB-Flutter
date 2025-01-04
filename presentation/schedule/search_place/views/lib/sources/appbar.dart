part of '../eb_search_place.dart';

final class _SearchPlaceAppBar extends AppBar {
  @override
  final String titleName;
  final Function()? cancelAction;
  @override
  final Widget? backButton;

  final Color color = EBColors.blue1;
  final String fontFamily = FontFamily.nanumSquareBold;
  final double fontSize = 17;

  _SearchPlaceAppBar({
    required this.titleName,
    required this.cancelAction,
    required this.backButton,
  });

  TextStyle textStyle() => TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
      );

  @override
  Color? get backgroundColor => Colors.white;
  @override
  double? get scrolledUnderElevation => 0;
  @override
  bool get automaticallyImplyLeading => false;
  @override
  double? get leadingWidth => 120; // dynamic하게 적용법?

  @override
  Widget? get title => Text(
        titleName,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          fontFamily: fontFamily,
        ),
      );

  @override
  List<Widget>? get actions => List<Widget>.of(
        (cancelAction != null)
            ? [
                TextButton(
                  onPressed: cancelAction,
                  child: Text(
                    '취소',
                    style: textStyle(),
                  ),
                )
              ]
            : [],
      );

  // @override
  // Widget? get leading => (backAction != null)
  //     ? NaviBackButton(
  //         parentViewName: '경로선택',
  //         onPressed: backAction,
  //       )
  //     : null;

  @override
  Widget? get leading => backButton;
}
