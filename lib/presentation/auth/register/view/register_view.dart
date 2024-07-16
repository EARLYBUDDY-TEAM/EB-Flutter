import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/presentation/auth/register/bloc/register_bloc.dart';
import 'package:earlybuddy/shared/eb_uikit/resources/eb_resources.dart';
import 'package:flutter/material.dart';
import 'package:earlybuddy/shared/eb_uikit/sources/eb_sources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appbar.dart';
part 'register_inputs.dart';
part 'register_request_button.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(context: context),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => RegisterBloc(
            authRepository: RepositoryProvider.of<EBAuthRepository>(context),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _RegisterInputs(),
                Spacer(),
                _RegisterButton(),
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
