part of '../../../../../eb_menu.dart';

final class _ChangePasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return EBButton(
          name: '변경',
          onPressed: state.changePasswordState.isInputValid
              ? () {
                  context.read<MenuBloc>().add(PressChangePasswordButton());
                }
              : null,
        );
      },
    );
  }
}
