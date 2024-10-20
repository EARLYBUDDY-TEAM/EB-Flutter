part of '../../../eb_add_schedule.dart';

final class _NotifyTransportForm extends StatelessWidget {
  final double fontSize;

  const _NotifyTransportForm({
    super.key,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddScheduleBloc, AddScheduleState>(
      buildWhen: (previous, current) {
        return previous.notifyTransportState != current.notifyTransportState;
      },
      builder: (context, state) {
        return RoundRectForm(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: _children(state.notifyTransportState),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _children(SealedNotifyTransportState notifyTransportState) {
    final List<Widget> listWidget = [_titleAndSwitch()];

    if (notifyTransportState is TrueNotifyTransportState) {
      listWidget.add(const NotifyTransportExpanded());
    }

    return listWidget;
  }

  Widget _titleAndSwitch() {
    return Row(
      children: [
        _IconPlusName(
          name: '배차알림',
          iconData: CupertinoIcons.bell,
          fontSize: fontSize,
          isActive: true,
        ),
        const Spacer(),
        const _NotifyTransportSwitch()
      ],
    );
  }
}

final class _NotifyTransportSwitch extends StatefulWidget {
  const _NotifyTransportSwitch({super.key});

  @override
  State<StatefulWidget> createState() => _NotifyTransportState();
}

final class _NotifyTransportState extends State<_NotifyTransportSwitch> {
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
        final notifyTransportState =
            isNotify ? TrueNotifyTransportState() : FalseNotifyTransportState();
        context.read<AddScheduleBloc>().add(
              ChangeNotifyTransport(
                notifyTransportState: notifyTransportState,
              ),
            );
      },
    );
  }
}
