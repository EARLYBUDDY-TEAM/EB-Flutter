part of 'login_view.dart';

final class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, EmailFormStatus>(
      selector: (state) => state.emailState.status,
      builder: (context, status) {
        return EBTextField(
          labelText: '이메일을 입력해주세요',
          onChanged: (email) =>
              context.read<LoginBloc>().add(ChangeEmail(email)),
          errorText: _errorText(status),
        );
      },
    );
  }

  String? _errorText(EmailFormStatus status) {
    switch (status) {
      case EmailFormStatus.onError:
        return '이메일을 확인해주세요.';
      default:
        return null;
    }
  }
}

final class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, PasswordFormStatus>(
      selector: (state) => state.passwordState.status,
      builder: (context, status) {
        return EBTextField(
          labelText: '비밀번호를 입력해주세요',
          onChanged: (password) =>
              context.read<LoginBloc>().add(ChangePassword(password)),
          errorText: _errorText(status),
        );
      },
    );
  }

  String? _errorText(PasswordFormStatus status) {
    switch (status) {
      case PasswordFormStatus.onError:
        return '비밀번호를 확인해주세요.';
      default:
        return null;
    }
  }
}
