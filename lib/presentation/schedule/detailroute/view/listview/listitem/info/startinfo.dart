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
        return _StartInfoItem.subway(
          ebSubPath.transports[0].subway!,
          ebSubPath.startName,
          () {},
        );
      case (2):
        return _StartInfoItem.bus(
          ebSubPath.transports[0].bus!,
          ebSubPath.startName,
          () {},
        );
      default:
        return _StartInfoItem.walk(ebSubPath.startName);
    }
  }
}

final class _StartInfoItem extends StatelessWidget {
  final List<Widget> rowChildren;
  static const double fontSize = 20;

  const _StartInfoItem({
    required this.rowChildren,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: NanumSquare.bold,
        fontSize: fontSize,
        color: EBColors.text,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: rowChildren,
      ),
    );
  }

  factory _StartInfoItem.walk(String startName) {
    return _StartInfoItem(
      rowChildren: [Text(startName)],
    );
  }

  factory _StartInfoItem.bus(
    Bus bus,
    String startName,
    Function() showMapAction,
  ) {
    return _StartInfoItem(
      rowChildren: [
        _StartTransportInfoItem(
          info: bus.number,
          color: bus.color(),
          fontSize: fontSize - 2,
        ),
        const SizedBox(width: 8),
        Text(startName),
        const Spacer(),
        EBRoundedButton(
          text: '지도보기',
          height: 25,
          onPressed: showMapAction,
        ),
      ],
    );
  }

  factory _StartInfoItem.subway(
    Subway subway,
    String startName,
    Function() showMapAction,
  ) {
    return _StartInfoItem(
      rowChildren: [
        _StartTransportInfoItem(
          info: subway.type,
          color: subway.color(),
          fontSize: fontSize - 2,
        ),
        const SizedBox(width: 8),
        Text(startName),
        const Spacer(),
        EBRoundedButton(
          text: '지도보기',
          height: 25,
          onPressed: showMapAction,
        ),
      ],
    );
  }
}

final class _StartTransportInfoItem extends StatelessWidget {
  final String info;
  final Color color;
  final double fontSize;

  const _StartTransportInfoItem({
    super.key,
    required this.info,
    required this.color,
    required this.fontSize,
  });

  /*
  info 한글일때 right 패딩값 조금 짧음...
  */

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Center(
        child: Text(
          info,
          style: TextStyle(
            fontFamily: NanumSquare.extraBold,
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
