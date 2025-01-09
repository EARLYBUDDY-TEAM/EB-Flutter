part of '../../../../../../eb_find_route.dart';

final class _StartInfo extends StatelessWidget {
  final SealedFindRouteSetting setting;
  final EBSubPath ebSubPath;
  final double fontSize = 20;

  const _StartInfo({
    required this.setting,
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
      content = StartInfoOther(
        setting: setting,
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
    return Row(
      children: [
        Flexible(
          child: Text(
            startName,
            style: TextStyle(
              fontFamily: FontFamily.nanumSquareBold,
              fontSize: fontSize,
              color: EBColors.text,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

final class StartInfoOther extends StatelessWidget {
  final SealedFindRouteSetting setting;
  final List<Transport> transportList;
  final String startName;
  final Coordi? startCoordi;
  final double fontSize;

  const StartInfoOther({
    super.key,
    required this.setting,
    required this.startName,
    required this.fontSize,
    required this.startCoordi,
    required this.transportList,
  });

  @override
  Widget build(BuildContext context) {
    final parentViewName = (setting is ReadFindRouteSetting) ? '경로보기' : '경로선택';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _children(
        context: context,
        parentViewName: parentViewName,
        setting: setting,
        startCoordi: startCoordi,
      ),
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
      Expanded(
        child: _DetailStartInfoPopupButton(
          transportMap: transportMap,
          startName: startName,
          fontSize: fontSize,
        ),
      ),
    ];

    if (startCoordi != null) {
      widgetList.add(
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 5),
          child: DetailShowMapButton(
            parentViewName: parentViewName,
            startCoordi: startCoordi,
            setting: setting,
            startName: startName,
          ),
        ),
      );
    }

    return widgetList;
  }
}
