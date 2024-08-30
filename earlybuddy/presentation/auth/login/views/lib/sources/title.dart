part of '../eb_login.dart';

final class _LoginTitle extends StatelessWidget {
  const _LoginTitle();

  @override
  Widget build(BuildContext context) {
    return Assets.images.loginTitle.image(
      height: 50,
      fit: BoxFit.fitHeight,
    );
  }
}
