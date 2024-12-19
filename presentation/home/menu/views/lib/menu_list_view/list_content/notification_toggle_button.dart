part of '../../../eb_menu.dart';

final class _NotificationToggleButton extends StatelessWidget {
  const _NotificationToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MenuBloc, MenuState, bool>(
      selector: (state) {
        return state.isNotification;
      },
      builder: (context, isNotification) {
        return CupertinoSwitch(
          activeColor: EBColors.blue2,
          value: isNotification,
          onChanged: _onChanged(context),
        );
      },
    );
  }

  Function(bool) _onChanged(BuildContext context) {
    return (bool isChecked) {
      log('isChecked: $isChecked');
      context.read<MenuBloc>().add(ToggleNotificationSwitch());
    };
  }
}

// final class _NotificationToggleButton extends StatefulWidget {
//   const _NotificationToggleButton({super.key});

//   @override
//   State<StatefulWidget> createState() => _NotificationToggleButtonState();
// }

// final class _NotificationToggleButtonState
//     extends State<_NotificationToggleButton> {
//   var _isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoSwitch(
//       activeColor: EBColors.blue2,
//       value: _isChecked,
//       onChanged: _onChanged,
//     );
//   }

//   void _onChanged(bool isChecked) {


//     setState(() {
//       _isChecked = isChecked;
//     });
//   }
// }
