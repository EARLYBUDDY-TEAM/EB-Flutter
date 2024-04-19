part of 'view.dart';

class _RegisterRequestButton extends StatelessWidget {
  const _RegisterRequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return EBButton(
          name: '시작하기',
          onPressed: state.inputIsValid
              ? () {
                  context.read<RegisterBloc>().add(const RegisterPressed());
                }
              : null,
        );
      },
    );
  }
}
