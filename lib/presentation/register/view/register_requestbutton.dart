part of 'register_view.dart';

class RegisterRequestButton extends StatelessWidget {
  const RegisterRequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return EBButton(
          name: '시작하기',
          onPressed: state.inputIsValid ? () {} : null,
        );
      },
    );
  }
}
