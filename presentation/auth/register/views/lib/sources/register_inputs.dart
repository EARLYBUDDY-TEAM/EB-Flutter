part of '../eb_register.dart';

final class _RegisterInputs extends StatelessWidget {
  const _RegisterInputs();

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareBold,
        color: EBColors.text,
        fontSize: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          _EmailInput(),
          const SizedBox(height: 30),
          _PasswordInput(),
          const SizedBox(height: 30),
          _PasswordConfirmInput(),
        ],
      ),
    );
  }
}

final class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('이메일'),
        BlocSelector<RegisterBloc, RegisterState, EmailFormStatus>(
          selector: (state) => state.emailState.status,
          builder: (context, status) {
            return EBTextField(
              labelText: '이메일을 입력해주세요.',
              errorText: _errorText(status),
              onChanged: (email) =>
                  context.read<RegisterBloc>().add(ChangeEmail(email)),
            );
          },
        ),
      ],
    );
  }

  String? _errorText(EmailFormStatus status) {
    switch (status) {
      case EmailFormStatus.onError:
        return '올바른 이메일이 아닙니다.';
      default:
        return null;
    }
  }
}

final class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('비밀번호'),
        BlocSelector<RegisterBloc, RegisterState, PasswordFormStatus>(
          selector: (state) => state.passwordState.status,
          builder: (context, status) {
            return EBPasswordTextField(
              onChanged: (password) =>
                  context.read<RegisterBloc>().add(ChangePassword(password)),
              labelText: '영어+숫자 6자 이상 입력해주세요.',
              errorText: _errorText(status),
            );
          },
        ),
      ],
    );
  }

  String? _errorText(PasswordFormStatus status) {
    switch (status) {
      case PasswordFormStatus.onError:
        return '영어+숫자 6자 이상 입력해주세요.';
      default:
        return null;
    }
  }
}

class _PasswordConfirmInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('비밀번호 확인'),
        BlocSelector<RegisterBloc, RegisterState, PasswordConfirmFormStatus>(
          selector: (state) => state.passwordConfirmState.status,
          builder: (context, status) {
            return EBPasswordTextField(
              onChanged: (passwordConfirm) => context
                  .read<RegisterBloc>()
                  .add(ChangePasswordConfirm(passwordConfirm)),
              labelText: '비밀번호를 한번 더 입력해주세요.',
              errorText: _errorText(status),
            );
          },
        ),
      ],
    );
  }

  String? _errorText(PasswordConfirmFormStatus status) {
    switch (status) {
      case PasswordConfirmFormStatus.onError:
        return '비밀번호가 일치하지 않습니다.';
      default:
        return null;
    }
  }
}
