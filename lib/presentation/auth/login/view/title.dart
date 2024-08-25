part of 'login_view.dart';

final class _LoginTitle extends StatelessWidget {
  const _LoginTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: EBImages.loginTitle,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
