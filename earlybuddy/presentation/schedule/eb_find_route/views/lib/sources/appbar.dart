part of '../eb_find_route.dart';

final class _FindRouteAppBar extends AppBar {
  final String? parentName;
  final Function()? cancelAction;
  final Function()? backAction;

  final Color color = EBColors.blue1;
  final String fontFamily = NanumSquare.bold;
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
  double? get leadingWidth => 130; // dynamic하게 적용법?

  @override
  Widget? get leading => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextButton(
          onPressed: backAction,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.arrow_back_ios_new,
                color: color,
              ),
              const SizedBox(width: 5),
              Text(
                parentName ?? '',
                style: TextStyle(
                  color: color,
                  fontFamily: fontFamily,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ),
      );

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
