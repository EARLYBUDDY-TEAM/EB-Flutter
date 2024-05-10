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

  // Is it possible to resize automatically?
  // @override
  // double? get leadingWidth => 150;

  @override
  Color? get backgroundColor => Colors.white;
  @override
  double? get scrolledUnderElevation => 0;
  @override
  bool get automaticallyImplyLeading => false;

  // @override
  // Widget? get leading => TextButton(
  //       onPressed: () => Navigator.of(context).pop(),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.max,
  //         children: [
  //           Icon(
  //             Icons.arrow_back_ios,
  //             color: color,
  //             size: fontSize + 5,
  //           ),
  //           Text('일정 등록', style: textStyle()),
  //         ],
  //       ),
  //     );

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
