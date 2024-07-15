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
          checkRoute(info.route);
        });
        return Row(
          children: [
            Text(info.route?.name ?? 'no data'),
            CupertinoSwitch(
              value: _isChecked,
              activeColor: EBColors.blue2,
              onChanged: (_) => _onChanged(
                context,
                info.place,
                info.route,
              ),
            ),
          ],
        );
      },
    );
  }

  void checkRoute(Place? route) {
    setState(() {
      _isChecked = route != null ? true : false;
    });
  }

  void _onChanged(
    BuildContext context,
    Place? place,
    Place? route,
  ) async {
    if (route == null) {
      if (place == null) {
        showNoDestinationAlert(context: context);
      } else {
        showCupertinoModalBottomSheet(
          context: context,
          expand: true,
          backgroundColor: Colors.white,
          builder: (context) => _searchPlaceView(context),
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
  Navigator _searchPlaceView(
    BuildContext context,
  ) {
    cancelAction() async {
      Navigator.of(context).pop();
    }

    final searchPlaceView = Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => Builder(
          builder: (_) => SearchPlaceView(
            delegate:
                RepositoryProvider.of<SearchPlaceDelegateForRoute>(context),
            setting: SearchPlaceSetting.departure,
            cancelAction: cancelAction,
          ),
        ),
      ),
    );

    return searchPlaceView;
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
