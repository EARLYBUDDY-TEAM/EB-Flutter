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
    return CupertinoSwitch(
      value: _isChecked,
      activeColor: EBColors.blue2,
      onChanged: _onChanged,
    );
  }

  void _onChanged(bool value) async {
    setState(() {
      _isChecked = value;
    });
    await Future<void>.delayed(const Duration(milliseconds: 500));
    showCupertinoModalBottomSheet(
      context: context,
      expand: true,
      backgroundColor: Colors.white,
      builder: (_) => _searchPlaceView(),
    );
  }

  Navigator _searchPlaceView() {
    return Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => Builder(
          builder: (_) => SearchPlaceView(),
        ),
      ),
    );
  }
}
