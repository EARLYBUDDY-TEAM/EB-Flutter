part of '../../../eb_add_schedule.dart';

final class _NotifyTransportForm extends StatelessWidget {
  final double fontSize;

  const _NotifyTransportForm({
    super.key,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddScheduleBloc, AddScheduleState,
        SealedNotifyTransportState>(
      selector: (state) {
        return state.notifyTransportState;
      },
      builder: (context, notifyTransportState) {
        return RoundRectForm(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: _children(notifyTransportState),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _children(
    SealedNotifyTransportState notifyTransportState,
  ) {
    final List<Widget> listWidget = [_titleAndSwitch(notifyTransportState)];

    if (notifyTransportState is TrueNotifyTransportState) {
      listWidget.add(
        NotifyTransportExpanded(
          initialBeforeNotifyMinute: notifyTransportState.beforeNotifyMinute,
          initialBeforeNotifyMinuteRange:
              notifyTransportState.beforeNotifyMinuteRange,
        ),
      );
    }

    return listWidget;
  }

  Widget _titleAndSwitch(
    SealedNotifyTransportState notifyTransportState,
  ) {
    final initialIsNotify =
        (notifyTransportState is TrueNotifyTransportState) ? true : false;

    return Row(
      children: [
        _IconPlusName(
          name: '배차알림',
          iconData: CupertinoIcons.bell,
          fontSize: fontSize,
          isActive: true,
        ),
        const Spacer(),
        _NotifyTransportSwitch(
          initialIsNotify: initialIsNotify,
        ),
      ],
    );
  }
}

final class _NotifyTransportSwitch extends StatefulWidget {
  final bool initialIsNotify;

  const _NotifyTransportSwitch({
    super.key,
    required this.initialIsNotify,
  });

  @override
  State<StatefulWidget> createState() => _NotifyTransportState();
}

final class _NotifyTransportState extends State<_NotifyTransportSwitch> {
  var _isNotify = false;

  void _setInitialIsNotify() {
    _isNotify = widget.initialIsNotify;
  }

  @override
  void didUpdateWidget(covariant _NotifyTransportSwitch oldWidget) {
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
    return BlocSelector<AddScheduleBloc, AddScheduleState,
        SealedStartPlaceState>(
      selector: (state) {
        return state.startPlaceState;
      },
      builder: (context, startPlaceState) {
        return CupertinoSwitch(
          value: _isNotify,
          activeColor: EBColors.blue2,
          onChanged: (bool isNotify) {
            _onChanged(
              context: context,
              startPlaceState: startPlaceState,
              isNotify: isNotify,
            );
          },
        );
      },
    );
  }

  void _onChanged({
    required BuildContext context,
    required SealedStartPlaceState startPlaceState,
    required bool isNotify,
  }) {
    if (startPlaceState is EmptyStartPlaceState) {
      _showNoPathDataAlert(context: context);
    } else {
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
    }
  }

  Future<void> _showNoPathDataAlert({
    required BuildContext context,
  }) async {
    await EBAlert.showModalPopup(
      context: context,
      title: '경로 데이터가 없습니다.',
      content: '출발장소(경로)를 먼저 정해주세요.',
      actions: [
        EBAlert.makeAction(
          name: '확인',
          onPressed: () {
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
        )
      ],
    );
  }
}
