part of 'findroute_view.dart';

final class _FindRouteAppBar extends AppBar {
  final Color color = EBColors.blue1;
  final String fontFamily = NanumSquare.bold;
  final double fontSize = 17;
  final Function()? cancelAction;

  _FindRouteAppBar(this.cancelAction);

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
            style: textStyle(),
          ),
        )
      ]);
}
