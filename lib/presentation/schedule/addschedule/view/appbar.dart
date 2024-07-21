part of 'addschedule_view.dart';

final class _AppBar extends AppBar {
  BuildContext context;

  _AppBar({required this.context});

  @override
  Widget? get title => const Text(
        '일정 등록',
        style: TextStyle(
          fontFamily: NanumSquare.bold,
          fontSize: 18,
        ),
      );

  @override
  Widget? get leading => IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      );
}
