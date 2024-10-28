part of '../../../eb_find_route.dart';

final class _FindRouteInfoView extends StatelessWidget {
  final double horizontalInset = 15;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindRouteBloc, FindRouteState>(
      buildWhen: (previous, current) {
        return previous.searchPlaceInfo != current.searchPlaceInfo;
      },
      builder: (context, state) {
        final startPlaceName = state.searchPlaceInfo.startPlace.name;
        final endPlaceName = state.searchPlaceInfo.endPlace.name;
        final pageChangeStartPlace = state.searchPlaceInfo.pageChangeStartPlace;
        final pageChangeEndPlace = state.searchPlaceInfo.pageChangeEndPlace;

        return Padding(
          padding: EdgeInsets.only(
            left: horizontalInset,
            right: horizontalInset,
            bottom: 20,
          ),
          child: Row(
            children: [
              infoImage(),
              SizedBox(width: horizontalInset),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _start(
                      context,
                      startPlaceName,
                      pageChangeStartPlace,
                    ),
                    _divider(),
                    _end(
                      context,
                      endPlaceName,
                      pageChangeEndPlace,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Image infoImage() {
    return Assets.images.markFindroute.image(
      width: 25,
      height: 60,
      fit: BoxFit.contain,
    );
  }

  Widget _divider() {
    return Divider(
      color: Colors.grey.withOpacity(0.5),
      thickness: 1,
    );
  }

  Widget _start(
    BuildContext context,
    String startPlaceName,
    MaterialPageRoute<dynamic> Function(BuildContext) pageChangeStartPlace,
  ) {
    return _placeText(
      context,
      startPlaceName,
      pageChangeStartPlace,
    );
  }

  Widget _end(
    BuildContext context,
    String endPlaceName,
    MaterialPageRoute<dynamic> Function(BuildContext) pageChangeEndPlace,
  ) {
    return _placeText(
      context,
      endPlaceName,
      pageChangeEndPlace,
    );
  }

  Widget _placeText(
    BuildContext context,
    String placeName,
    MaterialPageRoute<dynamic> Function(BuildContext) pageRoute,
  ) {
    return Row(
      children: [
        Text(
          placeName,
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareExtraBold,
            color: Colors.grey.withOpacity(0.7),
            fontSize: 15,
          ),
        ),
        const Spacer(),
        EBRoundedButton(
          text: '변경',
          height: 25,
          onPressed: () {
            Navigator.push(
              context,
              pageRoute(context),
            );
          },
        ),
      ],
    );
  }
}
