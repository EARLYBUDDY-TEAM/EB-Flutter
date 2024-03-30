import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:earlybuddy/login/login.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')));
        }
      },
      child: Column(
        children: [
          _EmailInput(),
          const Padding(padding: EdgeInsets.all(12)),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextField(
        onChanged: (email) =>
            context.read<LoginBloc>().add(LoginUsernameChanged(email)),
        decoration: const InputDecoration(
          labelText: '이메일을 입력해주세요',
          errorText: '잘못된 이메일입니다.',
        ),
      );
    });
  }
}
