part of '../../eb_register.dart';

final class _RegisterInputs extends StatelessWidget {
  const _RegisterInputs();

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareBold,
        color: EBColors.text,
        fontSize: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          _NameInput(),
          const SizedBox(height: 30),
          _EmailInput(),
          const SizedBox(height: 30),
          _PasswordInput(),
          const SizedBox(height: 30),
          _PasswordConfirmInput(),
        ],
      ),
    );
  }
}
