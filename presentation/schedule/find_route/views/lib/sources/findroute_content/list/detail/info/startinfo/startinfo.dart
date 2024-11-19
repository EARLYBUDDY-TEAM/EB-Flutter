part of '../../../../../../eb_find_route.dart';

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
      overflow: TextOverflow.ellipsis,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _children(
            context: context,
            parentViewName: parentViewName,
            setting: setting,
            startCoordi: startCoordi,
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
      _DetailStartInfoPopupButton(
        transNumber: transNumber,
        color: color,
        startName: startName,
        fontSize: fontSize,
      ),
    ];

    if (startCoordi != null) {
      widgetList.add(
        DetailShowMapButton(
          parentViewName: parentViewName,
          startCoordi: startCoordi,
          setting: setting,
          startName: startName,
        ),
      );
    }

    return widgetList;
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
