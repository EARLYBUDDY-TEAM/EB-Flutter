import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/presentation/auth/login/bloc/bloc.dart';
import 'package:earlybuddy/presentation/auth/register/register.dart';
import 'package:earlybuddy/shared/eb_uikit/resources/eb_resources.dart';
import 'package:earlybuddy/shared/eb_uikit/sources/eb_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'title.dart';
part 'input_forms.dart';
part 'auth_buttons.dart';

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
      child: Scaffold(
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
}
