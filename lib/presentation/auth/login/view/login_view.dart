import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/presentation/auth/login/bloc/login_bloc.dart';
import 'package:earlybuddy/presentation/auth/register/register.dart';
import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_title.dart';
part 'login_input.dart';
part 'login_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepository: RepositoryProvider.of<EBAuthRepository>(context),
        ),
        child: const Stack(
          children: [
            WaveBackground(),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  LoginTitle(),
                  Spacer(),
                  LoginInput(),
                  SizedBox(height: 40),
                  _LoginButton(),
                  SizedBox(height: 10),
                  _RegisterButton(),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
