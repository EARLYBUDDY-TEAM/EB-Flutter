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
    final startCoordi = ebSubPath.startCoordi;
    final startName = ebSubPath.startName;

    Widget content = _StartInfoWalk(
      startName: startName,
      fontSize: fontSize - 2,
    );

    if (transportList.isNotEmpty) {
      switch (transportList) {
        case List<Subway>():
          final subway = transportList.first;
          content = _StartInfoOther.subway(
            subway: subway,
            startName: startName,
            startCoordi: startCoordi,
            fontSize: fontSize,
          );
        case List<Bus>():
          final bus = transportList.first;
          content = _StartInfoOther.bus(
            bus: bus,
            startName: startName,
            startCoordi: startCoordi,
            fontSize: fontSize,
          );
        default:
          break;
      }
    }

    return content;
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
  final Coordi? startCoordi;
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
          children: _children(
            context: context,
            parentViewName: parentViewName,
            startCoordi: startCoordi,
            setting: setting,
          ),
        );
      },
    );
  }

  List<Widget> _children({
    required BuildContext context,
    required String parentViewName,
    required Coordi? startCoordi,
    required SealedFindRouteSetting setting,
  }) {
    final List<Widget> widgetList = [
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
    ];

    if (startCoordi != null) {
      widgetList.add(
        _showMapButton(
            context: context,
            parentViewName: parentViewName,
            startCoordi: startCoordi,
            setting: setting),
      );
    }

    return widgetList;
  }

  Widget _showMapButton({
    required BuildContext context,
    required String parentViewName,
    required Coordi startCoordi,
    required SealedFindRouteSetting setting,
  }) {
    return EBRoundedButton(
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
    required Coordi? startCoordi,
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
    required Coordi? startCoordi,
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
