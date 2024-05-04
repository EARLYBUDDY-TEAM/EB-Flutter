part of 'navermap_view.dart';

final class _NaverMapNaviBar extends CupertinoNavigationBar {
  BuildContext context;
  final Color color = EBColors.blue1;
  final String fontFamily = NanumSquare.bold;
  final double fontSize = 17;

  _NaverMapNaviBar({required this.context});

  TextStyle textStyle() => TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
      );

  @override
  Widget? get leading => TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: color,
              size: fontSize + 5,
            ),
            Text('일정 등록', style: textStyle()),
          ],
        ),
      );

  @override
  Widget? get middle => Text(
        '장소',
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          fontFamily: fontFamily,
        ),
      );

  @override
  Widget? get trailing => TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          '취소',
          style: textStyle(),
        ),
      );

  @override
  EdgeInsetsDirectional? get padding => EdgeInsetsDirectional.zero;
}
