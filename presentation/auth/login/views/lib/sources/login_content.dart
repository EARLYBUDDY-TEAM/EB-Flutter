part of '../eb_login.dart';

final class _LoginContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const SizedBox(height: 10),
                _AutoLoginColumn(),
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
    );
  }
}
