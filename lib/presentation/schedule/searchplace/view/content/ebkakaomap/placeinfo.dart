part of '../../searchplace_view.dart';

final class _EBKakaoMapPlaceInfo extends StatelessWidget {
  final Place place;

  const _EBKakaoMapPlaceInfo({required this.place});

  @override
  Widget build(BuildContext context) {
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
                    fontFamily: NanumSquare.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Text(
                  place.address,
                  style: const TextStyle(
                    fontFamily: NanumSquare.bold,
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const Spacer(),
            BlocSelector<SearchPlaceBloc, SearchPlaceState, SearchPlaceSetting>(
              selector: (state) {
                return state.viewState.setting;
              },
              builder: (context, setting) {
                return FilledButton(
                  onPressed: () => selectAction(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: EBColors.blue3,
                  ),
                  child: Text(
                    setting == SearchPlaceSetting.start ? '출발' : '선택',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: NanumSquare.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension on _EBKakaoMapPlaceInfo {
  void selectAction(BuildContext context) {
    context
        .read<SearchPlaceBloc>()
        .add(PressSelectPlaceButton(selectedPlace: place));
  }
}
