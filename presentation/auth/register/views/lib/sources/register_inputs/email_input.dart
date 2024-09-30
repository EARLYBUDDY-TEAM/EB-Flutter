part of '../../eb_register.dart';

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
