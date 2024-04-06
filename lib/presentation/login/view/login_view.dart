import 'dart:developer';

import 'package:earlybuddy/domain/auth_repository/auth_repository.dart';
import 'package:earlybuddy/presentation/login/login.dart';
import 'package:earlybuddy/presentation/register/register.dart';
import 'package:earlybuddy/shared/assets/font.dart';
import 'package:earlybuddy/shared/assets/image.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
        create: (context) {
          return LoginBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthRepository>(context),
          );
        },
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
                  LoginButton(),
                  SizedBox(height: 10),
                  RegisterButton(),
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

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        image: DecorationImage(image: EBImages.loginTitle, fit: BoxFit.fill),
      ),
    );
  }
}
