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
        return _EndInfoItem.subway(ebSubPath.endName);
      case (2):
        return _EndInfoItem.bus(ebSubPath.endName);
      default:
        return _EndInfoItem.walk(ebSubPath.endName);
    }
  }
}

final class _EndInfoItem extends StatelessWidget {
  final List<Widget> rowChildren;

  const _EndInfoItem({
    super.key,
    required this.rowChildren,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: NanumSquare.bold,
        fontSize: 20,
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

  factory _EndInfoItem.bus(String endName) {
    return _EndInfoItem(
      rowChildren: [Text(endName)],
    );
  }

  factory _EndInfoItem.subway(String endName) {
    return _EndInfoItem(
      rowChildren: [Text(endName)],
    );
  }
}
