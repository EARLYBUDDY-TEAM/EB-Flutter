part of '../../eb_detail_route.dart';

final class _StartInfo extends StatelessWidget {
  final EBSubPath ebSubPath;
  final Function() showMapAction;
  final double fontSize = 20;

  const _StartInfo({
    super.key,
    required this.ebSubPath,
    required this.showMapAction,
  });

  @override
  Widget build(BuildContext context) {
    switch (ebSubPath.type) {
      case (1):
        return _StartInfoOther.subway(
          subway: ebSubPath.transports[0].subway!,
          startName: ebSubPath.startName,
          fontSize: fontSize,
          showMapAction: showMapAction,
        );
      case (2):
        return _StartInfoOther.bus(
          bus: ebSubPath.transports[0].bus!,
          startName: ebSubPath.startName,
          fontSize: fontSize,
          showMapAction: showMapAction,
        );
      default:
        return _StartInfoWalk(
          startName: ebSubPath.startName,
          fontSize: fontSize - 2,
        );
    }
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
        fontFamily: NanumSquare.bold,
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
  final Function() showMapAction;
  final double fontSize;

  const _StartInfoOther({
    super.key,
    required this.transNumber,
    required this.color,
    required this.startName,
    required this.fontSize,
    required this.showMapAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _StartTransportNumber(
          number: transNumber,
          color: color,
          fontSize: fontSize - 2,
        ),
        const SizedBox(width: 8),
        Text(
          startName,
          style: TextStyle(
            fontFamily: NanumSquare.bold,
            fontSize: fontSize,
            color: EBColors.text,
          ),
        ),
        const Spacer(),
        EBRoundedButton(
          text: '지도보기',
          height: 25,
          onPressed: showMapAction,
        ),
      ],
    );
  }

  factory _StartInfoOther.bus({
    required Bus bus,
    required String startName,
    required double fontSize,
    required Function() showMapAction,
  }) {
    return _StartInfoOther(
      transNumber: bus.number,
      color: bus.color(),
      startName: startName,
      fontSize: fontSize,
      showMapAction: showMapAction,
    );
  }

  factory _StartInfoOther.subway({
    required Subway subway,
    required String startName,
    required double fontSize,
    required Function() showMapAction,
  }) {
    return _StartInfoOther(
      transNumber: subway.type,
      color: subway.color(),
      startName: startName,
      fontSize: fontSize,
      showMapAction: showMapAction,
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
            fontFamily: NanumSquare.extraBold,
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
