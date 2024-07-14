part of '../addschedule_view.dart';

final class _PlaceForm extends StatelessWidget {
  final double fontSize;

  const _PlaceForm({
    super.key,
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
              name: '장소',
              iconData: Icons.place_outlined,
              fontSize: fontSize,
              isActive: true,
            ),
            const Spacer(),
            TextButton(
              onPressed: () => showCupertinoModalBottomSheet(
                expand: true,
                context: context,
                backgroundColor: Colors.white,
                builder: _searchPlaceView,
              ),
              child: BlocSelector<AddScheduleBloc, AddScheduleState, String>(
                selector: (state) => unwrapPlace(state.info.place),
                builder: (context, placeName) {
                  return Text(
                    placeName,
                    style: TextStyle(
                      fontFamily: NanumSquare.bold,
                      fontSize: fontSize,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Builder _searchPlaceView(BuildContext context) {
    cancelAction() {
      Navigator.of(context).pop();
    }

    return Builder(
      builder: (context) => Navigator(
        onGenerateRoute: (context) => MaterialPageRoute(
          builder: (context) => Builder(
            builder: (context) => SearchPlaceView(
              setting: SearchPlaceSetting.destination,
              cancelAction: cancelAction,
            ),
          ),
        ),
      ),
    );
  }

  String unwrapPlace(Place? place) {
    if (place != null && place.name.trim().isNotEmpty) {
      return place.name;
    } else {
      return '추가하기';
    }
  }
}
