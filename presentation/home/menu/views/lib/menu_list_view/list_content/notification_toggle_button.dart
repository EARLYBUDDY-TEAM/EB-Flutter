part of '../../../eb_menu.dart';

final class _NotificationToggleButton extends StatelessWidget {
  var previousStatus = NotificationStatus.disabled;

  _NotificationToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MenuBloc, MenuState, NotificationStatus>(
      selector: (state) {
        return state.notificationStatus;
      },
      builder: (context, status) {
        return CupertinoSwitch(
          activeColor: EBColors.blue2,
          value: _getValue(status),
          onChanged: _onChanged(
            context: context,
            status: status,
          ),
        );
      },
    );
  }

  bool _getValue(NotificationStatus curStatus) {
    bool value;
    if (curStatus == NotificationStatus.checking) {
      value = previousStatus == NotificationStatus.enabled;
    } else {
      value = curStatus == NotificationStatus.enabled;
    }
    previousStatus = curStatus;
    return value;
  }

  Function(bool)? _onChanged({
    required BuildContext context,
    required NotificationStatus status,
  }) {
    return status == NotificationStatus.checking
        ? null
        : (bool isChecked) {
            context.read<MenuBloc>().add(ToggleNotificationSwitch());
          };
  }
}
