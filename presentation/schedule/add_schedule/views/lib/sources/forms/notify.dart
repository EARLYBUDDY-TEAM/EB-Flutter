part of '../../eb_add_schedule.dart';

class _NotifyForm extends StatelessWidget {
  final double fontSize;

  const _NotifyForm({
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
            _NotifySwitch()
          ],
        ),
      ),
    );
  }
}

class _NotifySwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotifyState();
}

class _NotifyState extends State<_NotifySwitch> {
  var _isNotify = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: _isNotify,
      activeColor: EBColors.blue2,
      onChanged: (bool isNotify) {
        setState(() {
          _isNotify = isNotify;
        });
        context.read<AddScheduleBloc>().add(ChangeNotify(isNotify));
      },
    );
  }
}
