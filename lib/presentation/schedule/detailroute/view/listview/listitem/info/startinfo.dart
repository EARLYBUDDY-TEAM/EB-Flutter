part of '../../../detailroute_view.dart';

final class _StartInfo extends StatelessWidget {
  final EBSubPath ebSubPath;

  const _StartInfo({
    super.key,
    required this.ebSubPath,
  });

  @override
  Widget build(BuildContext context) {
    switch (ebSubPath.type) {
      case (1):
        return _StartInfoItem.subway(ebSubPath.startName, () {});
      case (2):
        return _StartInfoItem.bus(ebSubPath.startName, () {});
      default:
        return _StartInfoItem.walk(ebSubPath.startName);
    }
  }
}

final class _StartInfoItem extends StatelessWidget {
  final List<Widget> rowChildren;

  const _StartInfoItem({
    required this.rowChildren,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: rowChildren,
    );
  }

  factory _StartInfoItem.walk(String startName) {
    return _StartInfoItem(
      rowChildren: [Text(startName)],
    );
  }

  factory _StartInfoItem.bus(
    String startName,
    Function() showMapAction,
  ) {
    return _StartInfoItem(
      rowChildren: [
        Text(startName),
        const Spacer(),
        EBRoundedButton(
          text: '지도보기',
          height: 20,
          onPressed: showMapAction,
        ),
      ],
    );
  }

  factory _StartInfoItem.subway(
    String startName,
    Function() showMapAction,
  ) {
    return _StartInfoItem(
      rowChildren: [
        Text(startName),
        const Spacer(),
        EBRoundedButton(
          text: '지도보기',
          height: 20,
          onPressed: showMapAction,
        ),
      ],
    );
  }
}
