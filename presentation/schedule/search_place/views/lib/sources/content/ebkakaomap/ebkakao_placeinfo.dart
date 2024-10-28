part of '../../../eb_search_place.dart';

final class _EBKakaoMapPlaceInfo extends StatelessWidget {
  final Place place;

  const _EBKakaoMapPlaceInfo({
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    final setting = context.read<SearchPlaceBloc>().state.setting;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: const TextStyle(
                    fontFamily: FontFamily.nanumSquareBold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Text(
                  place.address,
                  style: const TextStyle(
                    fontFamily: FontFamily.nanumSquareBold,
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const Spacer(),
            FilledButton(
              onPressed: () => _selectAction(context),
              style: FilledButton.styleFrom(
                backgroundColor: EBColors.blue3,
              ),
              child: Text(
                (setting is StartSearchPlaceSetting) ? '출발' : '선택',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: FontFamily.nanumSquareBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on _EBKakaoMapPlaceInfo {
  void _selectAction(BuildContext context) {
    context
        .read<SearchPlaceBloc>()
        .add(PressSelectPlaceButton(selectedPlace: place));

    final setting = context.read<SearchPlaceBloc>().state.setting;

    switch (setting) {
      case (StartSearchPlaceSetting()):
        Navigator.of(context).push(setting.pageFindRoute(place));
      case (EndSearchPlaceSetting()):
        context.read<SearchPlaceBloc>().add(PressCancelButton());
      default:
        Navigator.of(context).pop();
    }
  }
}
