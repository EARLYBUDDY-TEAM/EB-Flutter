part of '../eb_search_place.dart';

final class _SearchPlaceAppBar extends AppBar {
  @override
  final String textTitle;
  final VoidCallback cancelAction;

  final Color color = EBColors.blue1;
  final String fontFamily = FontFamily.nanumSquareBold;
  final double fontSize = 17;

  _SearchPlaceAppBar({
    required this.textTitle,
    required this.cancelAction,
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
  Widget? get title => Text(
        textTitle,
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
            style: textStyle(),
          ),
        )
      ]);
}
