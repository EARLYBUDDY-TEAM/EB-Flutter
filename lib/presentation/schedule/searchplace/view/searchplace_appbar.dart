part of 'searchplace_view.dart';

final class _SearchPlaceAppBar extends AppBar {
  BuildContext context;
  final Color color = EBColors.blue1;
  final String fontFamily = NanumSquare.bold;
  final double fontSize = 17;

  _SearchPlaceAppBar({required this.context});

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
        '장소',
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          fontFamily: fontFamily,
        ),
      );

  @override
  List<Widget>? get actions => List<Widget>.of([
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            '취소',
            style: textStyle(),
          ),
        )
      ]);
}
