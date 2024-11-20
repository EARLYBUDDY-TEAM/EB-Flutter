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
      content = _StartInfoOther(
        startName: startName,
        fontSize: fontSize,
        startCoordi: startCoordi,
        transportList: transportList,
      );
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
  final List<Transport> transportList;
  final String startName;
  final Coordi? startCoordi;
  final double fontSize;

  const _StartInfoOther({
    super.key,
    required this.startName,
    required this.fontSize,
    required this.startCoordi,
    required this.transportList,
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
    final transportMap = createTransportMap(transportList);

    final List<Widget> widgetList = [
      _DetailStartInfoPopupButton(
        realTimeInfoList: _mockRealTimeInfo,
        transportMap: transportMap,
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

  List<RealTimeInfo> get _mockRealTimeInfo {
    return transportList.map<RealTimeInfo>((t) {
      return RealTimeInfo.mock(
        transportName: t.getName(),
      );
    }).toList();
  }
}
