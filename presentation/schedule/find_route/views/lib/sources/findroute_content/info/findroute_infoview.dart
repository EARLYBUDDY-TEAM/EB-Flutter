part of '../../../eb_find_route.dart';

final class _FindRouteInfoView extends StatelessWidget {
  final double horizontalInset = 15;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FindRouteBloc, FindRouteState, SearchPlaceInfo>(
      selector: (state) {
        return state.searchPlaceInfo;
      },
      builder: (context, searchPlaceInfo) {
        final startPlaceName = searchPlaceInfo.startPlace?.name;
        final endPlaceName = searchPlaceInfo.endPlace?.name;

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
                    ),
                    _divider(),
                    _end(
                      context,
                      endPlaceName,
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
    String? startPlaceName,
  ) {
    final setting = context.read<FindRouteBloc>().state.setting;
    final pageChangeStartPlace = (setting is WriteFindRouteSetting)
        ? setting.pageChangeStartPlace
        : null;
    return _placeText(
      context: context,
      placeName: startPlaceName ?? "출발 장소",
      pageRoute: pageChangeStartPlace,
    );
  }

  Widget _end(
    BuildContext context,
    String? endPlaceName,
  ) {
    final setting = context.read<FindRouteBloc>().state.setting;
    final pageChangeEndPlace =
        (setting is WriteFindRouteSetting) ? setting.pageChangeEndPlace : null;
    return _placeText(
      context: context,
      placeName: endPlaceName ?? "도착 장소",
      pageRoute: pageChangeEndPlace,
    );
  }

  Widget _placeText({
    required BuildContext context,
    required String placeName,
    required MaterialPageRoute<dynamic> Function(BuildContext)? pageRoute,
  }) {
    final List<Widget> children = [
      Text(
        placeName,
        style: TextStyle(
          fontFamily: FontFamily.nanumSquareExtraBold,
          color: Colors.grey.withOpacity(0.7),
          fontSize: 15,
        ),
      ),
      const Spacer(),
    ];

    if (pageRoute != null) {
      children.add(_changeButton(
        context: context,
        pageRoute: pageRoute,
      ));
    }

    return Row(children: children);
  }

  Widget _changeButton({
    required BuildContext context,
    required MaterialPageRoute<dynamic> Function(BuildContext) pageRoute,
  }) {
    return EBRoundedButton(
      text: '변경',
      height: 25,
      onPressed: () {
        Navigator.push(
          context,
          pageRoute(context),
        );
      },
    );
  }
}
