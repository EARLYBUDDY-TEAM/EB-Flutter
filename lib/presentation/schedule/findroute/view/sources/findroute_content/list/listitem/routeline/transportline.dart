part of '../../../../findroute_view.dart';

class _TransportLine extends StatelessWidget {
  final double height;
  final TransportLineOfPath lineOfPath;

  const _TransportLine({
    required height,
    required this.lineOfPath,
  }) : height = height + 3;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: lineOfPath.lineOfPath
            .map((lineInfo) => _line(lineInfo: lineInfo))
            .toList());
  }

  Flexible _line({
    required TransportLineInfo lineInfo,
  }) {
    return Flexible(
      flex: lineInfo.length,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: lineInfo.color,
              borderRadius: BorderRadius.all(Radius.circular(height / 2)),
            ),
            height: height,
          ),
          Transform.translate(
            offset: const Offset(0, 20),
            child: Text(
              lineInfo.name ?? '${lineInfo.length}분',
              style: _textStyle(lineInfo.color),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _textStyle(Color? color) {
    if (color != null) {
      return TextStyle(
        fontFamily: NanumSquare.extraBold,
        fontSize: 20,
        color: color,
      );
    } else {
      return TextStyle(
        fontFamily: NanumSquare.regular,
        fontSize: 14,
        color: EBColors.text,
      );
    }
  }
}
