part of '../../../detailroute_view.dart';

final class _EndInfo extends StatelessWidget {
  final EBSubPath ebSubPath;

  const _EndInfo({
    super.key,
    required this.ebSubPath,
  });

  @override
  Widget build(BuildContext context) {
    switch (ebSubPath.type) {
      case (1):
        return _EndInfoItem.subway(
          ebSubPath.transports[0].subway!,
          ebSubPath.endName,
        );
      case (2):
        return _EndInfoItem.bus(
          ebSubPath.transports[0].bus!,
          ebSubPath.endName,
        );
      default:
        return _EndInfoItem.walk(ebSubPath.endName);
    }
  }
}

final class _EndInfoItem extends StatelessWidget {
  final List<Widget> rowChildren;
  static const double fontSize = 20;

  const _EndInfoItem({
    super.key,
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
        children: rowChildren,
      ),
    );
  }

  factory _EndInfoItem.walk(String endName) {
    final text = '$endName까지 걷기';
    return _EndInfoItem(
      rowChildren: [Text(text)],
    );
  }

  factory _EndInfoItem.bus(Bus bus, String endName) {
    return _EndInfoItem(
      rowChildren: [
        _EndGetOffInfoItem(
          color: bus.color(),
          fontSize: fontSize - 2,
        ),
        const SizedBox(width: 8),
        Text(endName),
      ],
    );
  }

  factory _EndInfoItem.subway(Subway subway, String endName) {
    return _EndInfoItem(
      rowChildren: [
        _EndGetOffInfoItem(
          color: subway.color(),
          fontSize: fontSize - 2,
        ),
        const SizedBox(width: 8),
        Text(endName),
      ],
    );
  }
}

final class _EndGetOffInfoItem extends StatelessWidget {
  final Color color;
  final double fontSize;

  const _EndGetOffInfoItem({
    super.key,
    required this.color,
    required this.fontSize,
  });

  /*
  info 한글일때 right 패딩값 조금 짧음...
  */

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: color, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Center(
        child: Text(
          '하차',
          style: TextStyle(
            fontFamily: NanumSquare.extraBold,
            fontSize: fontSize,
            color: color,
          ),
        ),
      ),
    );
  }
}
