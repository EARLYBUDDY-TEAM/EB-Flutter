part of 'register_view.dart';

class RegisterInput extends StatelessWidget {
  const RegisterInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        _EmailInput(),
        const SizedBox(height: 30),
        _PasswordInput(),
        const SizedBox(height: 30),
        _PasswordConfirmInput(),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RegisterText(text: '이메일'),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return EBTextField(
              onChanged: (email) =>
                  context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
              labelText: '이메일을 입력해주세요.',
              errorText: state.emailState.isValidEmail ? null : '이메일을 확인해주세요',
            );
          },
        ),
      ],
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RegisterText(text: '비밀번호'),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return EBTextField(
              onChanged: (password) => context
                  .read<RegisterBloc>()
                  .add(RegisterPasswordChanged(password)),
              labelText: '영어+숫자 6자 이상 입력해주세요.',
              errorText: state.passwordState.isValidPassword
                  ? null
                  : '영어+숫자 6자 이상 입력해주세요.',
            );
          },
        ),
      ],
    );
  }
}

class _PasswordConfirmInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RegisterText(text: '비밀번호 확인'),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return EBTextField(
              onChanged: (passwordConfirm) => context
                  .read<RegisterBloc>()
                  .add(RegisterPasswordConfirmChanged(passwordConfirm)),
              labelText: '비밀번호를 한번 더 입력해주세요.',
              errorText: state.passwordConfirmState.isValidPasswordConfirm
                  ? null
                  : '비밀번호가 일치하지 않습니다.',
            );
          },
        ),
      ],
    );
  }
}

class _RegisterText extends StatelessWidget {
  _RegisterText({
    required this.text,
  });

  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: NanumSquare.bold,
        color: EBColors.text,
        fontSize: 20,
      ),
    );
  }
}
