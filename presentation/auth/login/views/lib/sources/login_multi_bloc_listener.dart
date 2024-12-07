part of '../eb_login.dart';

final class _LoginMultiBlocListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        _showExpiredTokenAlertListener(),
        _showLoginFailAlertListener(),
        _showLogoutSnackBarListener(),
      ],
      child: _LoginContent(),
    );
  }
}

extension on _LoginMultiBlocListener {
  BlocListener<LoginBloc, LoginState> _showExpiredTokenAlertListener() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        await _showExpiredTokenAlert(
          context,
          state.tokenStatus,
        );
      },
    );
  }

  Future<void> _showExpiredTokenAlert(
    BuildContext context,
    BaseStatus status,
  ) async {
    if (status != BaseStatus.fail) {
      return;
    }

    await EBAlert.showModalPopup(
      context: context,
      title: '장기간 사용하지 않아 로그아웃 되었습니다.',
      content: '다시 로그인 해주세요.',
      actions: [
        EBAlert.makeAction(
          name: '확인',
          onPressed: () {
            context
                .read<LoginBloc>()
                .add(const SetTokenStatus(status: BaseStatus.init));
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
        )
      ],
    );
  }
}

extension on _LoginMultiBlocListener {
  BlocListener<LoginBloc, LoginState> _showLoginFailAlertListener() {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) {
        return previous.loginStatus != current.loginStatus;
      },
      listener: (context, state) async {
        await _showLoginFailAlert(
          context,
          state.loginStatus,
        );
      },
    );
  }

  Future<void> _showLoginFailAlert(
    BuildContext context,
    LoginStatus status,
  ) async {
    if (status != LoginStatus.onError) {
      return;
    }

    await EBAlert.showModalPopup(
      context: context,
      title: '로그인에 실패했습니다.',
      content: '네트워크 연결상태와 아이디 비밀번호를 확인해주세요.',
      actions: [
        EBAlert.makeAction(
          name: '확인',
          onPressed: () {
            context.read<LoginBloc>().add(const PressAlertOkButton());
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
        )
      ],
    );
  }
}

extension on _LoginMultiBlocListener {
  BlocListener<LoginBloc, LoginState> _showLogoutSnackBarListener() {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) {
        return previous.completeLogout != current.completeLogout;
      },
      listener: (context, state) async {
        await _showLogoutSnackBar(
          context,
        );
      },
    );
  }

  Future<void> _showLogoutSnackBar(
    BuildContext context,
  ) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    final snackBar = EBSnackBar(text: '로그아웃 되었습니다.');
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
