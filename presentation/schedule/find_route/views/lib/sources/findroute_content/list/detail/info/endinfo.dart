part of '../../../../../eb_find_route.dart';

final class _EndInfo extends StatelessWidget {
  final EBSubPath ebSubPath;
  final double fontSize = 20;

  const _EndInfo({
    super.key,
    required this.ebSubPath,
  });

  @override
  Widget build(BuildContext context) {
    final transportList = ebSubPath.transportList;
    final endName = ebSubPath.endName;
    Widget content = _EndInfoWalk(
      endName: endName,
      fontSize: fontSize - 2,
    );

    if (transportList.isNotEmpty) {
      switch (transportList) {
        case List<Subway>():
          final subway = transportList.first;
          content = _EndInfoOther.subway(
            subway: subway,
            endName: endName,
            fontSize: fontSize,
          );
        case List<Bus>():
          final bus = transportList.first;
          content = _EndInfoOther.bus(
            bus: bus,
            endName: endName,
            fontSize: fontSize,
          );
        default:
          break;
      }
    }

    return content;
  }
}

final class _EndInfoWalk extends StatelessWidget {
  final String endName;
  final double fontSize;

  const _EndInfoWalk({
    super.key,
    required this.endName,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      endName,
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareBold,
        fontSize: fontSize,
        color: EBColors.text,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

final class _EndInfoOther extends StatelessWidget {
  final String endName;
  final Color color;
  final double fontSize;

  const _EndInfoOther({
    super.key,
    required this.endName,
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _EndGetOffInfoItem(
          color: color,
          fontSize: fontSize - 2,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 150,
          child: Text(
            endName,
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

  factory _EndInfoOther.subway({
    required Subway subway,
    required String endName,
    required double fontSize,
  }) {
    return _EndInfoOther(
      endName: endName,
      color: subway.color(),
      fontSize: fontSize,
    );
  }

  factory _EndInfoOther.bus({
    required Bus bus,
    required String endName,
    required double fontSize,
  }) {
    return _EndInfoOther(
      endName: endName,
      color: bus.color(),
      fontSize: fontSize,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
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
            fontFamily: FontFamily.nanumSquareExtraBold,
            fontSize: fontSize,
            color: color,
          ),
        ),
      ),
    );
  }
}
