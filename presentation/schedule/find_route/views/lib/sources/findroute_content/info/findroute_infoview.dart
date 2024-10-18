part of '../../../eb_find_route.dart';

final class _FindRouteInfoView extends StatelessWidget {
  final double horizontalInset = 15;

  @override
  Widget build(BuildContext context) {
    final state = context.read<FindRouteBloc>().state;
    final startPlaceName = state.searchPlaceInfo.startPlace.name;
    final endPlaceName = state.searchPlaceInfo.endPlace.name;

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
                _start(context, startPlaceName),
                _divider(),
                _end(context, endPlaceName),
              ],
            ),
          ),
        ],
      ),
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

  Widget _end(
    BuildContext context,
    String endPlaceName,
  ) {
    return Row(
      children: [
        Text(
          endPlaceName,
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
            final pageChangeEndPlace = context
                .read<FindRouteBloc>()
                .state
                .searchPlaceInfo
                .pageChangeEndPlace;
            Navigator.push(
              context,
              pageChangeEndPlace(context),
            );
          },
        ),
      ],
    );
  }

  Widget _start(
    BuildContext context,
    String startPlaceName,
  ) {
    return Row(
      children: [
        Text(
          startPlaceName,
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            color: EBColors.text,
            fontSize: 15,
          ),
        ),
        const Spacer(),
        EBRoundedButton(
          text: '변경',
          height: 25,
          onPressed: () {
            final pageChangeStartPlace = context
                .read<FindRouteBloc>()
                .state
                .searchPlaceInfo
                .pageChangeStartPlace;

            Navigator.push(
              context,
              pageChangeStartPlace(context),
            );
          },
        ),
      ],
    );
  }
}
