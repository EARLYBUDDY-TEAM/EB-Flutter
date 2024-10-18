part of '../../eb_add_schedule.dart';

class _RouteForm extends StatelessWidget {
  final double fontSize;

  const _RouteForm({
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return RoundRectForm(
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
    return BlocSelector<AddScheduleBloc, AddScheduleState, Schedule>(
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
        showNoEndPlaceDataAlert(context: context);
      } else {
        showCupertinoModalBottomSheet(
          context: context,
          expand: true,
          backgroundColor: Colors.white,
          builder: (_) => _searchPlaceView(endPlace),
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
    Place endPlace,
  ) {
    return Material(
      child: Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) => SearchPlaceView(
              setting: StartSearchPlaceSetting(
                endPlace: endPlace,
                pageFindRoute: (startPlace) => _pageFindRoute(
                  startPlace: startPlace,
                  endPlace: endPlace,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  MaterialPageRoute _pageFindRoute({
    required Place startPlace,
    required Place endPlace,
  }) {
    return MaterialPageRoute(
      builder: (_) => FindRouteView(
        startPlace: startPlace,
        endPlace: endPlace,
        pageChangeStartPlace: SearchPlaceView.pageChangeStartPlace,
        pageChangeEndPlace: SearchPlaceView.pageChangeEndPlace,
        parentName: '출발 장소',
      ),
    );
  }

  // MaterialPageRoute _pageChangeStartPlace(BuildContext context) {
  //   return MaterialPageRoute(
  //     builder: (context) => SearchPlaceView(
  //       setting: ChangeStartSearchPlaceSetting(),
  //     ),
  //   );
  // }

  // MaterialPageRoute _pageChangeEndPlace(BuildContext context) {
  //   return MaterialPageRoute(
  //     builder: (context) => SearchPlaceView(
  //       setting: ChangeEndSearchPlaceSetting(),
  //     ),
  //   );
  // }
}

extension on _RouteState {
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
