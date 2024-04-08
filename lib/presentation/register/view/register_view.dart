import 'package:earlybuddy/presentation/register/bloc/register_bloc.dart';
import 'package:earlybuddy/shared/assets/font.dart';
import 'package:earlybuddy/shared/assets/color.dart';
import 'package:flutter/material.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_appbar.dart';
part 'register_input.dart';
part 'register_requestbutton.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegisterAppBar(context: context),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => RegisterBloc(),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                RegisterInput(),
                Spacer(),
                RegisterRequestButton(),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
