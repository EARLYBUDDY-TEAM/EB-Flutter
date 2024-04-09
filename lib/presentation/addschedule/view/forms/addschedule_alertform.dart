part of '../addschedule_view.dart';

class _AlertForm extends StatelessWidget {
  final double fontSize;

  const _AlertForm({
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return _RoundRectForm(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            _IconPlusName(
              name: '일정알림',
              iconData: CupertinoIcons.bell,
              fontSize: fontSize,
              isActive: true,
            ),
            const Spacer(),
            _AlertSwitch()
          ],
        ),
      ),
    );
  }
}

class _AlertSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AlertState();
}

class _AlertState extends State<_AlertSwitch> {
  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: _isChecked,
      activeColor: EBColors.blue2,
      onChanged: (bool value) {
        setState(() {
          _isChecked = value;
        });
      },
    );
  }
}
