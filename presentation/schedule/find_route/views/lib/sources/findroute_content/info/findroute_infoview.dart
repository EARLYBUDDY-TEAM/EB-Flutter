part of '../../../eb_find_route.dart';

final class _FindRouteInfoView extends StatelessWidget {
  final double horizontalInset = 15;

  @override
  Widget build(BuildContext context) {
    final state = context.read<FindRouteBloc>().state;
    final startPlaceName = state.startPlace.name;
    final endPlaceName = state.endPlace.name;

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
                _start(startPlaceName),
                _divider(),
                _end(endPlaceName),
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

  Row _start(String startPlaceName) {
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
        const EBRoundedButton(
          text: '변경',
          height: 25,
        ),
      ],
    );
  }

  Divider _divider() {
    return Divider(
      color: Colors.grey.withOpacity(0.5),
      thickness: 1,
    );
  }

  Text _end(String endPlaceName) {
    return Text(
      endPlaceName,
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareExtraBold,
        color: Colors.grey.withOpacity(0.7),
        fontSize: 15,
      ),
    );
  }
}
