import 'package:earlybuddy/presentation/asset/EBFont.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginContent(),
    );
  }
}

class LoginContent extends StatelessWidget {
  final Container rect = Container(
    width: double.infinity,
    height: 200,
    decoration: const BoxDecoration(
      color: Colors.blue,
    ),
  );

  LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          rect,
          const EBTextField(labelText: '아이디를 입력해주세요.'),
          const EBTextField(labelText: '비밀번호를 입력해주세요.'),
        ],
      ),
    );
  }
}

class EBTextField extends StatelessWidget {
  final String labelText;

  const EBTextField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.blue,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.blue,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey,
            ),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(fontFamily: NanumSquare.regular)),
    );
  }
}
