part of 'register_view.dart';

class RegisterAppBar extends AppBar {
  BuildContext context;

  RegisterAppBar({super.key, required this.context});

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
