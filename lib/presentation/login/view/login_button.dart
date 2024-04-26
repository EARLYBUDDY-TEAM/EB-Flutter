part of 'login_view.dart';

class _LoginButton extends StatelessWidget {
  const _LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : EBButton(
                name: '로그인',
                onPressed: () {
                  context.read<LoginBloc>().add(const LoginPressed());
                },
              );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const RegisterView()));
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
