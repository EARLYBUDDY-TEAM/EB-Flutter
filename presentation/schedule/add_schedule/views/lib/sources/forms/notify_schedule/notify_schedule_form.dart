part of '../../../eb_add_schedule.dart';

final class _NotifyScheduleForm extends StatelessWidget {
  final double fontSize;

  const _NotifyScheduleForm({
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddScheduleBloc, AddScheduleState,
        SealedNotifyScheduleState>(
      selector: (state) {
        return state.notifyScheduleState;
      },
      builder: (context, notifyScheduleState) {
        return RoundRectForm(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: _children(notifyScheduleState),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _children(SealedNotifyScheduleState notifyScheduleState) {
    final List<Widget> listWidget = [_titleAndSwitch(notifyScheduleState)];

    if (notifyScheduleState is TrueNotifyScheduleState) {
      listWidget.add(
        NotifyScheduleExpanded(
          initialBeforeNotifyMinute: notifyScheduleState.beforeNotifyMinute,
        ),
      );
    }

    return listWidget;
  }

  Widget _titleAndSwitch(SealedNotifyScheduleState notifyScheduleState) {
    final initialIsNotify =
        (notifyScheduleState is TrueNotifyScheduleState) ? true : false;

    return Row(
      children: [
        _IconPlusName(
          name: '일정알림',
          iconData: CupertinoIcons.bell,
          fontSize: fontSize,
          isActive: true,
        ),
        const Spacer(),
        _NotifyScheduleSwitch(
          initialIsNotify: initialIsNotify,
        ),
      ],
    );
  }
}

final class _NotifyScheduleSwitch extends StatefulWidget {
  final bool initialIsNotify;

  const _NotifyScheduleSwitch({
    super.key,
    required this.initialIsNotify,
  });

  @override
  State<StatefulWidget> createState() => _NotifyScheduleState();
}

final class _NotifyScheduleState extends State<_NotifyScheduleSwitch> {
  var _isNotify = false;

  void _setInitialIsNotify() {
    _isNotify = widget.initialIsNotify;
  }

  @override
  void didUpdateWidget(covariant _NotifyScheduleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIsNotify != widget.initialIsNotify) {
      _setInitialIsNotify();
    }
  }

  @override
  void initState() {
    super.initState();
    _setInitialIsNotify();
  }

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
