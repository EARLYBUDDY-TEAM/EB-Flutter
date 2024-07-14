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
  final routeName = '_RouteForm';

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddScheduleBloc, AddScheduleState, String?>(
      selector: (state) {
        return state.info.place;
      },
      builder: (context, place) {
        return CupertinoSwitch(
          value: _isChecked,
          activeColor: EBColors.blue2,
          onChanged: (bool value) {
            _onChanged(context, value, place);
          },
        );
      },
    );
  }

  void showNoDestinationAlert({
    required BuildContext context,
    required VoidCallback okAction,
  }) {
    Widget okButton = TextButton(
      child: const Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
        okAction();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('장소(목적지) 데이터가 없습니다.'),
      content: const Text('장소를 먼저 정해주세요.'),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

  void _onChanged(
    BuildContext context,
    bool value,
    String? place,
  ) async {
    setState(() {
      _isChecked = value;
    });

    if (place == null) {
      showNoDestinationAlert(
        context: context,
        okAction: () {
          setState(() {
            _isChecked = !value;
          });
        },
      );
    } else {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      showCupertinoModalBottomSheet(
        context: context,
        expand: true,
        backgroundColor: Colors.white,
        builder: _searchPlaceView,
      );
    }
  }

  Builder _searchPlaceView(BuildContext context) {
    selectAction(Place place) {
      log(place.name);
      context.read<AddScheduleBloc>().add(SelectRoute(place: place));
    }

    cancelAction() {
      Navigator.of(context).pop();
    }

    final searchPlaceView = Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => Builder(
          builder: (_) => SearchPlaceView(
            setting: SearchPlaceSetting.departure,
            cancelAction: cancelAction,
          ),
        ),
      ),
    );
    return Builder(builder: (context) => searchPlaceView);
  }
}
