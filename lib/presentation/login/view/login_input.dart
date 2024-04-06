part of 'login_view.dart';

class LoginInput extends StatelessWidget {
  const LoginInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          // ScaffoldMessenger.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(
          //       const SnackBar(content: Text('Authentication Failure')));
          // context.read<LoginBloc>().add(const LoginDidAppearSnackBar());
        }
      },
      child: Column(
        children: [
          _EmailInput(),
          const SizedBox(height: 10),
          _PasswordInput(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return EBTextField(
          labelText: '이메일을 입력해주세요',
          onChanged: (email) =>
              context.read<LoginBloc>().add(LoginEmailChanged(email)),
          errorText: (state.emailState.isError) ? '아이디를 확인해주세요.' : null,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return EBTextField(
          labelText: '비밀번호를 입력해주세요',
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          errorText: (state.passwordState.isError) ? '비밀번호를 확인해주세요.' : null,
        );
      },
    );
  }
}
