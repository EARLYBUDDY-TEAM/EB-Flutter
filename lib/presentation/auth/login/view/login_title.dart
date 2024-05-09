part of 'login_view.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        image: DecorationImage(image: EBImages.loginTitle, fit: BoxFit.fill),
      ),
    );
  }
}
