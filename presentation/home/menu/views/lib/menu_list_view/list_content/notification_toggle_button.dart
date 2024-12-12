part of '../../../eb_menu.dart';

final class _NotificationToggleButton extends StatefulWidget {
  const _NotificationToggleButton({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationToggleButtonState();
}

final class _NotificationToggleButtonState
    extends State<_NotificationToggleButton> {
  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      activeColor: EBColors.blue2,
      value: _isChecked,
      onChanged: _onChanged,
    );
  }

  void _onChanged(bool isChecked) {
    setState(() {
      _isChecked = isChecked;
    });
  }
}
