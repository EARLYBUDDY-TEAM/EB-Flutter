part of 'login_view.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : EBButton(
                name: '로그인',
                onPressed: state.isValid
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}

class RegisterButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const RegisterButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // return TextButton(onPressed: () )
    return TextButton(
      onPressed: onPressed,
      style: const ButtonStyle(),
      child: const Text(
        '회원가입',
        style: TextStyle(
          fontFamily: NanumSquare.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}

// textStyle: const TextStyle(
//           fontFamily: NanumSquare.bold,
//           fontSize: 20,
//         ),