part of '../eb_login.dart';

final class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const LoginView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authRepository: RepositoryProvider.of<EBAuthRepository>(context),
        homeDelegate: RepositoryProvider.of<HomeDelegate>(context),
        loginDelegate: RepositoryProvider.of<LoginDelegate>(context),
      ),
      child: _LoginContent(),
    );
  }
}

class _LoginContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        showLoginFailAlert(
          context,
          state.status,
        );
        showExpiredTokenAlert(
          context,
          state.tokenStatus,
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const WaveBackground(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  const _LoginTitle(),
                  const Spacer(),
                  _EmailInput(),
                  const SizedBox(height: 10),
                  _PasswordInput(),
                  const SizedBox(height: 40),
                  const _LoginButton(),
                  const SizedBox(height: 10),
                  const _RegisterButton(),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLoginFailAlert(
    BuildContext context,
    LoginStatus status,
  ) {
    if (status != LoginStatus.onError) {
      return;
    }

    EBAlert.showModalPopup(
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

  void showExpiredTokenAlert(
    BuildContext context,
    BaseStatus status,
  ) {
    if (status != BaseStatus.fail) {
      return;
    }

    EBAlert.showModalPopup(
      context: context,
      title: '장기간 사용하지 않아 로그아웃 되었습니다.',
      content: '다시 로그인해주세요.',
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
