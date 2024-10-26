part of '../../eb_add_schedule.dart';

final class _PlaceForm extends StatelessWidget {
  final double fontSize;

  const _PlaceForm({
    super.key,
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
                builder: builderModalBottomSheet(
                  context: context,
                  onGenerateRoute: SearchPlaceView.pageEndSearchPlace(context),
                ),
              ),
              child: BlocSelector<AddScheduleBloc, AddScheduleState, String>(
                selector: (state) => unwrapPlace(state.schedule.endPlace),
                builder: (context, end) {
                  return Text(
                    end,
                    style: TextStyle(
                      fontFamily: FontFamily.nanumSquareBold,
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

  String unwrapPlace(Place? place) {
    if (place != null && place.name.trim().isNotEmpty) {
      return place.name;
    } else {
      return '추가하기';
    }
  }
}
