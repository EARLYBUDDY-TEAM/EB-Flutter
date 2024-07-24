import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/presentation/auth/login/bloc/bloc.dart';
import 'package:earlybuddy/presentation/auth/register/register.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'title.dart';
part 'input_forms.dart';
part 'buttons.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginView());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authRepository: RepositoryProvider.of<EBAuthRepository>(context),
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
        if (state.status == LoginStatus.onError) {
          showLoginFailAlert(context);
        }
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

  void showLoginFailAlert(BuildContext context) {
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
}
