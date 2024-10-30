part of '../../../eb_add_schedule.dart';

class StartPlaceForm extends StatelessWidget {
  final double fontSize;

  const StartPlaceForm({
    super.key,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddScheduleBloc, AddScheduleState>(
      buildWhen: (previous, current) {
        return previous.startPlaceState != current.startPlaceState;
      },
      builder: (context, state) {
        return RoundRectForm(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: _children(state.startPlaceState),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _children(SealedStartPlaceState startPlaceState) {
    final List<Widget> listWidget = [
      _startPlaceForm(),
    ];

    if (startPlaceState is SelectedStartPlaceState) {
      listWidget.add(const StartPlaceExpanded());
    }

    return listWidget;
  }

  Widget _startPlaceForm() {
    return Row(
      children: [
        _IconPlusName(
          name: '경로',
          iconData: Icons.map_outlined,
          fontSize: fontSize,
          isActive: true,
        ),
        const Spacer(),
        _StartPlaceSwitch(),
      ],
    );
  }
}

final class _StartPlaceSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StartPlaceSwitchState();
}

final class _StartPlaceSwitchState extends State<_StartPlaceSwitch> {
  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddScheduleBloc, AddScheduleState>(
      buildWhen: (previous, current) {
        final flag1 = previous.startPlaceState != current.startPlaceState;
        final flag2 = current.schedule.endPlace != null;
        return (flag1 || flag2);
      },
      builder: (context, state) {
        final startPlaceState = state.startPlaceState;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _isChecked =
                (startPlaceState is SelectedStartPlaceState) ? true : false;
          });
        });
        return CupertinoSwitch(
          value: _isChecked,
          activeColor: EBColors.blue2,
          onChanged: (_) => _onChanged(
            context: context,
            startPlaceState: startPlaceState,
            endPlace: state.schedule.endPlace,
          ),
        );
      },
    );
  }

  void checkRoute(Place? start) {
    setState(() {
      _isChecked = start != null ? true : false;
    });
  }

  void _onChanged({
    required BuildContext context,
    required SealedStartPlaceState startPlaceState,
    required Place? endPlace,
  }) {
    if (startPlaceState is EmptyStartPlaceState) {
      if (endPlace == null) {
        showNoEndPlaceDataAlert(context: context);
      } else {
        showCupertinoModalBottomSheet(
          context: context,
          expand: true,
          backgroundColor: Colors.white,
          builder: builderModalBottomSheet(
            context: context,
            onGenerateRoute: _pageStartsearchPlace(
              context: context,
              endPlace: endPlace,
            ),
          ),
        );
      }
    } else {
      showRemoveRouteAlert(
        context: context,
        removeAction: () =>
            context.read<AddScheduleBloc>().add(const RemoveStartPlace()),
      );
    }
  }
}

extension on _StartPlaceSwitchState {
  MaterialPageRoute _pageStartsearchPlace({
    required BuildContext context,
    required Place endPlace,
  }) {
    return SearchPlaceView.pageStartSearchPlace(
      context: context,
      setting: StartSearchPlaceSetting(
        endPlace: endPlace,
        pageFindRoute: (startPlace) => AddScheduleView.pageWriteFindRoute(
          context: context,
          startPlace: startPlace,
          endPlace: endPlace,
          parentName: "출발장소",
        ),
      ),
    );
  }
}

extension on _StartPlaceSwitchState {
  void showNoEndPlaceDataAlert({
    required BuildContext context,
  }) {
    EBAlert.showModalPopup(
      context: context,
      title: '장소(목적지) 데이터가 없습니다.',
      content: '장소를 먼저 정해주세요.',
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

  void showRemoveRouteAlert({
    required BuildContext context,
    required Function() removeAction,
  }) {
    EBAlert.showModalPopup(
      context: context,
      title: '경로설정을 취소할까요?',
      content: '설정한 경로 데이터가 사라집니다.',
      actions: [
        EBAlert.makeAction(
          name: '지우기',
          onPressed: () {
            Navigator.of(context).pop();
            removeAction();
          },
          isDestructiveAction: true,
        ),
        EBAlert.makeAction(
          name: '취소',
          onPressed: () {
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
        ),
      ],
    );
  }
}
