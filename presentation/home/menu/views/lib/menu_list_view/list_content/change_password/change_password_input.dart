part of '../../../../eb_menu.dart';

final class _ChangePasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<MenuBloc, MenuState, FormStatus>(
      selector: (state) {
        return state.changePasswordState.passwordState.status;
      },
      builder: (context, status) {
        return EBPasswordTextField(
          onChanged: (password) =>
              context.read<MenuBloc>().add(ChangePassword(password: password)),
          labelText: '영어+숫자 6자 이상 입력해주세요.',
          errorText: _errorText(status),
        );
      },
    );
  }

  String? _errorText(FormStatus status) {
    switch (status) {
      case FormStatus.inComplete:
        return '영어+숫자 6자 이상 입력해주세요.';
      default:
        return null;
    }
  }
}

class _ChangePasswordConfirmInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<MenuBloc, MenuState, FormStatus>(
      selector: (state) {
        return state.changePasswordState.passwordConfirmState.status;
      },
      builder: (context, status) {
        return EBPasswordTextField(
          onChanged: (passwordConfirm) => context
              .read<MenuBloc>()
              .add(ChangePasswordConfirm(passwordConfirm: passwordConfirm)),
          labelText: '비밀번호를 한번 더 입력해주세요.',
          errorText: _errorText(status),
        );
      },
    );
  }

  String? _errorText(FormStatus status) {
    switch (status) {
      case FormStatus.inComplete:
        return '비밀번호가 일치하지 않습니다.';
      default:
        return null;
    }
  }
}
