part of '../../../../../eb_find_route.dart';

final class _StartInfo extends StatelessWidget {
  final EBSubPath ebSubPath;
  final double fontSize = 20;

  const _StartInfo({
    super.key,
    required this.ebSubPath,
  });

  @override
  Widget build(BuildContext context) {
    final transportList = ebSubPath.transportList;

    switch (transportList) {
      case SubwayList():
        final subway = transportList.subwayList.firstOrNull;
        final startCoordi = ebSubPath.startCoordi;
        if ((subway == null) || (startCoordi == null)) {
          break;
        }
        return _StartInfoOther.subway(
          subway: subway,
          startName: ebSubPath.startName,
          startCoordi: startCoordi,
          fontSize: fontSize,
        );
      case BusList():
        final bus = transportList.busList.firstOrNull;
        final startCoordi = ebSubPath.startCoordi;
        if ((bus == null) || (startCoordi == null)) {
          break;
        }
        return _StartInfoOther.bus(
          bus: bus,
          startName: ebSubPath.startName,
          startCoordi: ebSubPath.startCoordi!,
          fontSize: fontSize,
        );
      default:
        return _StartInfoWalk(
          startName: ebSubPath.startName,
          fontSize: fontSize - 2,
        );
    }

    return _StartInfoWalk(
      startName: ebSubPath.startName,
      fontSize: fontSize - 2,
    );
  }
}

final class _StartInfoWalk extends StatelessWidget {
  final String startName;
  final double fontSize;

  const _StartInfoWalk({
    super.key,
    required this.startName,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      startName,
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareBold,
        fontSize: fontSize,
        color: EBColors.text,
      ),
    );
  }
}

final class _StartInfoOther extends StatelessWidget {
  final String transNumber;
  final Color color;
  final String startName;
  final Coordi startCoordi;
  final double fontSize;

  const _StartInfoOther({
    super.key,
    required this.transNumber,
    required this.color,
    required this.startName,
    required this.fontSize,
    required this.startCoordi,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FindRouteBloc, FindRouteState, SealedFindRouteSetting>(
      selector: (state) {
        return state.setting;
      },
      builder: (context, setting) {
        final parentViewName =
            (setting is ReadFindRouteSetting) ? '경로보기' : '경로선택';

        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            _StartTransportNumber(
              number: transNumber,
              color: color,
              fontSize: fontSize - 2,
            ),
            const SizedBox(width: 8),
            Text(
              startName,
              style: TextStyle(
                fontFamily: FontFamily.nanumSquareBold,
                fontSize: fontSize,
                color: EBColors.text,
              ),
            ),
            const Spacer(),
            EBRoundedButton(
              text: '지도보기',
              height: 25,
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
            ),
          ],
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

  factory _StartInfoOther.bus({
    required Bus bus,
    required String startName,
    required Coordi startCoordi,
    required double fontSize,
  }) {
    return _StartInfoOther(
      transNumber: bus.number,
      color: bus.color(),
      startName: startName,
      startCoordi: startCoordi,
      fontSize: fontSize,
    );
  }

  factory _StartInfoOther.subway({
    required Subway subway,
    required String startName,
    required Coordi startCoordi,
    required double fontSize,
  }) {
    return _StartInfoOther(
      transNumber: subway.type,
      color: subway.color(),
      startName: startName,
      startCoordi: startCoordi,
      fontSize: fontSize,
    );
  }
}

final class _StartTransportNumber extends StatelessWidget {
  final String number;
  final Color color;
  final double fontSize;

  const _StartTransportNumber({
    super.key,
    required this.number,
    required this.color,
    required this.fontSize,
  });

  /*
  한글일때 마지막글자 패딩값
  */

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareExtraBold,
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
