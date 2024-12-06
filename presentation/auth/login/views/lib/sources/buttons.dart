part of '../eb_login.dart';

final class _LoginButton extends StatelessWidget {
  const _LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return EBButton(
      name: '로그인',
      onPressed: () {
        context.read<LoginBloc>().add(const PressLoginButton());
      },
    );
  }
}

final class _RegisterButton extends StatelessWidget {
  const _RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RegisterView(),
          ),
        );
      },
      child: Text(
        '회원가입',
        style: TextStyle(
          fontFamily: FontFamily.nanumSquareExtraBold,
          fontSize: 20,
          color: EBColors.text,
        ),
      ),
    );
  }
}

final class _AutoLoginColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, bool>(
      selector: (state) {
        return state.isAutoLogin;
      },
      builder: (context, isAutoLogin) {
        return Row(
          children: [
            _AutoLoginButton(isAutoLogin: isAutoLogin),
            const Spacer(),
          ],
        );
      },
    );
  }
}

final class _AutoLoginButton extends StatelessWidget {
  final bool isAutoLogin;
  get _iconColor {
    return isAutoLogin ? EBColors.blue2 : Colors.grey.shade500;
  }

  get _textColor {
    return isAutoLogin ? EBColors.text : Colors.grey.shade600;
  }

  const _AutoLoginButton({
    super.key,
    required this.isAutoLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          context.read<LoginBloc>().add(
                PressAutoLoginButton(isAutoLogin: !isAutoLogin),
              );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 3,
            vertical: 8,
          ),
          child: _buttonContent(),
        ),
      ),
    );
  }

  Widget _buttonContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: _iconColor,
          size: 28,
        ),
        const SizedBox(width: 5),
        Text(
          "자동 로그인",
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareRegular,
            fontSize: 16,
            color: _textColor,
          ),
        ),
      ],
    );
  }
}
