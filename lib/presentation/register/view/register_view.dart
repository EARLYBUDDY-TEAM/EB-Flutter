import 'dart:developer';

import 'package:earlybuddy/presentation/register/bloc/register_bloc.dart';
import 'package:earlybuddy/shared/assets/font.dart';
import 'package:earlybuddy/shared/assets/color.dart';
import 'package:flutter/material.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_input.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegisterAppBar(context: context),
      body: BlocProvider(
        create: (context) => RegisterBloc(),
        child: const RegisterInput(),
      ),
    );
  }
}

class RegisterAppBar extends AppBar {
  BuildContext context;

  RegisterAppBar({super.key, required this.context});

  @override
  Widget? get title => const Text(
        '회원가입',
        style: TextStyle(
          fontFamily: NanumSquare.bold,
          fontSize: 18,
        ),
      );

  @override
  Widget? get leading => IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      );
}


//  @required BuildContext context,