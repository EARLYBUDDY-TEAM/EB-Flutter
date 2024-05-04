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
                builder: (context) => const SearchPlaceView(),
              ),
              child: Text(
                '추가하기',
                style: TextStyle(
                  fontFamily: NanumSquare.bold,
                  fontSize: fontSize,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
