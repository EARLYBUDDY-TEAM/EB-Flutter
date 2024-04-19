part of 'view.dart';

class _AppBar extends AppBar {
  BuildContext context;

  _AppBar({super.key, required this.context});

  @override
  Widget? get title => const Text(
        '회원가입',
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
