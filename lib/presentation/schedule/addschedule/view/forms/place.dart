part of '../addschedule_view.dart';

class _PlaceForm extends StatelessWidget {
  final double fontSize;

  const _PlaceForm({
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
                builder: (context, place) {
                  return Text(
                    place,
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
    selectAction(Place place) {
      log(place.name);
      // context.read<AddScheduleBloc>().add(SelectPlace(place: place));
      // BlocProvider.of<AddScheduleBloc>(context).add(SelectPlace(place: place));
    }

    cancelAction() {
      Navigator.of(context).pop();
    }

    return Builder(
      builder: (context) => Navigator(
        onGenerateRoute: (context) => MaterialPageRoute(
          builder: (context) => Builder(
            builder: (context) => SearchPlaceView(
              setting: SearchPlaceSetting.destination,
              selectAction: selectAction,
              cancelAction: cancelAction,
            ),
          ),
        ),
      ),
    );
  }

  String unwrapPlace(String? place) {
    if (place != null && place.trim().isNotEmpty) {
      return place;
    } else {
      return '추가하기';
    }
  }
}
