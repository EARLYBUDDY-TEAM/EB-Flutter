part of '../../eb_register.dart';

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
