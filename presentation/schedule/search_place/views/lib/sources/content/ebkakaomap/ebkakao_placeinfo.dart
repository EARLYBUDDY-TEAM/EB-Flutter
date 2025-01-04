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
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: KeyboardVisibilityBuilder(
          key: const Key('_EBKakaoMapPlaceInfo'),
          builder: (context, isKeyboardVisible) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _placeInfoText(isKeyboardVisible),
                const Spacer(),
                _selectButton(
                  context: context,
                  setting: setting,
                  isKeyboardVisible: isKeyboardVisible,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _placeInfoText(bool isKeyboardVisible) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _placeInfoTextContent(isKeyboardVisible),
    );
  }
}

extension on _EBKakaoMapPlaceInfo {
  List<Widget> _placeInfoTextContent(bool isKeyboardVisible) {
    if (isKeyboardVisible) {
      return [
        const SizedBox(height: 20),
        _placeNameText(),
      ];
    } else {
      return [
        const SizedBox(height: 20),
        _placeNameText(),
        _placeAddressText(),
      ];
    }
  }

  Widget _placeAddressText() {
    return Text(
      place.address,
      style: const TextStyle(
        fontFamily: FontFamily.nanumSquareBold,
        fontSize: 18,
        color: Colors.black54,
      ),
    );
  }

  Widget _placeNameText() {
    return Text(
      place.name,
      style: const TextStyle(
        fontFamily: FontFamily.nanumSquareBold,
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }
}

extension on _EBKakaoMapPlaceInfo {
  Widget _selectButton(
      {required BuildContext context,
      required SearchPlaceSetting setting,
      required bool isKeyboardVisible}) {
    return Column(
      children: [
        SizedBox(height: isKeyboardVisible ? 10 : 20),
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
    );
  }

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
