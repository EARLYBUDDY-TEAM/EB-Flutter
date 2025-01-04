part of '../../../../../../eb_find_route.dart';

final class DetailShowMapButton extends StatelessWidget {
  final String startName;
  final String parentViewName;
  final Coordi startCoordi;
  final SealedFindRouteSetting setting;

  const DetailShowMapButton({
    super.key,
    required this.parentViewName,
    required this.startCoordi,
    required this.setting,
    required this.startName,
  });

  @override
  Widget build(BuildContext context) {
    return DetailShowMapButtonContent(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FindRouteKakaoMapView(
              parentViewName: parentViewName,
              placeName: startName,
              coordi: startCoordi,
              cancelAction: _cancelAction(
                context: context,
                setting: setting,
              ),
            ),
          ),
        );
      },
    );
  }

  Function()? _cancelAction({
    required BuildContext context,
    required SealedFindRouteSetting setting,
  }) {
    return (setting is ReadFindRouteSetting)
        ? () {
            final homeDelegate = RepositoryProvider.of<HomeDelegate>(context);
            homeDelegate.cancelModalView.add(());
          }
        : null;
  }
}

final class DetailShowMapButtonContent extends StatelessWidget {
  final Function()? onPressed;

  const DetailShowMapButtonContent({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return EBRoundedButton(
      text: '지도보기',
      height: 25,
      onPressed: onPressed,
    );
  }
}
