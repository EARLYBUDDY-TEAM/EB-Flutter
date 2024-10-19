part of '../../../eb_add_schedule.dart';

class _NotifyScheduleForm extends StatelessWidget {
  final double fontSize;

  const _NotifyScheduleForm({
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddScheduleBloc, AddScheduleState>(
      buildWhen: (previous, current) {
        return previous.notifyScheduleState != current.notifyScheduleState;
      },
      builder: (context, state) {
        return RoundRectForm(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: _children(state.notifyScheduleState),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _children(SealedNotifyScheduleState notifyScheduleState) {
    final List<Widget> listWidget = [_titleAndSwitch()];

    if (notifyScheduleState is TrueNotifyScheduleState) {
      listWidget.add(const NotifyScheduleExpanded());
    }

    return listWidget;
  }

  Widget _titleAndSwitch() {
    return Row(
      children: [
        _IconPlusName(
          name: '일정알림',
          iconData: CupertinoIcons.bell,
          fontSize: fontSize,
          isActive: true,
        ),
        const Spacer(),
        _NotifyScheduleSwitch()
      ],
    );
  }
}

class _NotifyScheduleSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotifyState();
}

class _NotifyState extends State<_NotifyScheduleSwitch> {
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
        final notifyScheduleState = isNotify
            ? TrueNotifyScheduleState(beforeNotifyMinute: 10)
            : FalseNotifyScheduleState();
        context.read<AddScheduleBloc>().add(
              ChangeNotifySchedule(notifyScheduleState: notifyScheduleState),
            );
      },
    );
  }
}
