part of '../../eb_detail_route.dart';

final class _EndInfo extends StatelessWidget {
  final EBSubPath ebSubPath;
  final double fontSize = 20;

  const _EndInfo({
    super.key,
    required this.ebSubPath,
  });

  @override
  Widget build(BuildContext context) {
    switch (ebSubPath.type) {
      case (1):
        final subway = ebSubPath.transports[0].subway!;
        return _EndInfoOther.subway(
          subway: subway,
          endName: ebSubPath.endName,
          fontSize: fontSize,
        );
      case (2):
        final bus = ebSubPath.transports[0].bus!;
        return _EndInfoOther.bus(
          bus: bus,
          endName: ebSubPath.endName,
          fontSize: fontSize,
        );
      default:
        return _EndInfoWalk(
          endName: ebSubPath.endName,
          fontSize: fontSize - 2,
        );
    }
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
        Text(
          endName,
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            fontSize: fontSize,
            color: EBColors.text,
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
