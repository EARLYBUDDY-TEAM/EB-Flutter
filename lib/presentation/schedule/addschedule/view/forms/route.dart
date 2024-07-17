part of '../addschedule_view.dart';

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
              iconData: Icons.map_outlined,
              fontSize: fontSize,
              isActive: true,
            ),
            const Spacer(),
            _RouteSwitch(),
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
    return BlocSelector<AddScheduleBloc, AddScheduleState, AddScheduleInfo>(
      selector: (state) {
        return state.info;
      },
      builder: (context, info) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          checkRoute(info.startPlace);
        });
        return Row(
          children: [
            Text(info.startPlace?.name ?? 'no data'),
            CupertinoSwitch(
              value: _isChecked,
              activeColor: EBColors.blue2,
              onChanged: (_) => _onChanged(
                context,
                info.startPlace,
                info.endPlace,
              ),
            ),
          ],
        );
      },
    );
  }

  void checkRoute(Place? start) {
    setState(() {
      _isChecked = start != null ? true : false;
    });
  }

  void _onChanged(
    BuildContext context,
    Place? startPlace,
    Place? endPlace,
  ) {
    if (startPlace == null) {
      if (endPlace == null) {
        showNoDestinationAlert(context: context);
      } else {
        showCupertinoModalBottomSheet(
          context: context,
          expand: true,
          backgroundColor: Colors.white,
          builder: (_) => _searchPlaceView(context),
        );
      }
    } else {
      showRemoveRouteAlert(
        context: context,
        removeAction: () =>
            context.read<AddScheduleBloc>().add(const RemoveRoute()),
      );
    }
  }
}

extension on _RouteState {
  Material _searchPlaceView(
    BuildContext addScheduleContext,
  ) {
    cancelAction(BuildContext addScheduleContext) {
      Navigator.of(addScheduleContext).pop();
    }

    selectAction(
      Place start,
      BuildContext addScheduleContext,
      BuildContext searchPlaceContext,
    ) {
      final info =
          BlocProvider.of<AddScheduleBloc>(addScheduleContext).state.info;
      final Place? end = info.endPlace;
      if (end != null) {
        Navigator.push(
          searchPlaceContext,
          MaterialPageRoute(
            builder: (searchPlaceContext) => FindRouteView(
              start: start,
              end: end,
              parentName: '출발 장소',
              backAction: () => Navigator.of(searchPlaceContext).pop(),
              cancelAction: () => Navigator.of(addScheduleContext).pop(),
            ),
          ),
        );
      }
    }

    return Material(
      child: Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => Builder(
            builder: (searchPlaceContext) => SearchPlaceView(
              setting: SearchPlaceSetting.start,
              delegate: RepositoryProvider.of<SearchPlaceDelegateForRoute>(
                  addScheduleContext),
              selectAction: (start) =>
                  selectAction(start, addScheduleContext, searchPlaceContext),
              cancelAction: () => cancelAction(addScheduleContext),
            ),
          ),
        ),
      ),
    );
  }
}

extension on _RouteState {
  void showNoDestinationAlert({
    required BuildContext context,
  }) {
    Widget ok = TextButton(
      child: const Text('확인'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('장소(목적지) 데이터가 없습니다.'),
      content: const Text('장소를 먼저 정해주세요.'),
      actions: [ok],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

  void showRemoveRouteAlert({
    required BuildContext context,
    required Function() removeAction,
  }) {
    Widget remove = TextButton(
      child: const Text(
        '지우기',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        removeAction();
      },
    );

    Widget cancel = TextButton(
      child: const Text('취소'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('경로설정을 취소할까요?'),
      content: const Text('설정한 경로 데이터가 사라집니다.'),
      actions: [remove, cancel],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }
}
