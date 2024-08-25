part of 'login_view.dart';

class _LoginButton extends StatelessWidget {
  const _LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return EBButton(
      name: '로그인',
      onPressed: () {
        context.read<LoginBloc>().add(const PressLoginButton());
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RegisterView(),
          ),
        );
      },
      child: Text(
        '회원가입',
        style: TextStyle(
          fontFamily: NanumSquare.extraBold,
          fontSize: 20,
          color: EBColors.text,
        ),
      ),
    );
  }
}
