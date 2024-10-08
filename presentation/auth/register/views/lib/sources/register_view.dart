part of '../eb_register.dart';

final class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        ebAuthRepository: RepositoryProvider.of<EBAuthRepository>(context),
        tokenRepository: RepositoryProvider.of<TokenRepository>(context),
        rootDelegate: RepositoryProvider.of<RootDelegate>(context),
        homeDelegate: RepositoryProvider.of<HomeDelegate>(context),
        loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
      ),
      child: _RegisterContent(),
    );
  }
}

final class _RegisterContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        showRegisterFailAlert(context, state.status);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _appBar(context),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _RegisterInputs(),
                Spacer(),
                _RegisterButton(),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        '회원가입',
        style: TextStyle(
          fontFamily: FontFamily.nanumSquareBold,
          fontSize: 18,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }

  void showRegisterFailAlert(
    BuildContext context,
    RegisterStatus status,
  ) {
    if (status == RegisterStatus.initial ||
        status == RegisterStatus.inProgress) {
      return;
    }

    String title = '회원가입에 실패했습니다.';
    String content;
    switch (status) {
      case (RegisterStatus.onErrorExsitUser):
        content = '이미 존재하는 사용자입니다.';
      case (RegisterStatus.onErrorNotCorrectUser):
        content = '이메일, 패스워드 형식이 올바른지 확인해주세요.';
      case (RegisterStatus.onErrorLogin):
        title = '회원가입에는 성공했으나 로그인에 실패했습니다.';
        content = '네트워크 상태를 확인후 로그인 화면에서 다시 시도해주세요.';
      default:
        content = '네트워크 상태를 확인해주세요.';
    }
    EBAlert.showModalPopup(
      context: context,
      title: title,
      content: content,
      actions: [
        EBAlert.makeAction(
          name: '확인',
          onPressed: () {
            context.read<RegisterBloc>().add(const PressAlertOkButton());
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
        )
      ],
    );
  }
}
