part of '../view.dart';

class _RouteForm extends StatelessWidget {
  final double fontSize;

  const _RouteForm({
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
              name: '경로',
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

class _RouteSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RouteState();
}

class _RouteState extends State<_RouteSwitch> {
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
