part of '../../eb_register.dart';

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
