part of '../../../../findroute_view.dart';

class _TransportLine extends StatelessWidget {
  final double height;
  final TransportLineOfPath lineOfPath;
  final int totalTime;

  const _TransportLine({
    required height,
    required this.lineOfPath,
    required this.totalTime,
  }) : height = height + 3;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return Row(
        children: lineOfPath.lineOfPath.map((lineInfo) {
          final String text = lineInfo.name;
          final TextStyle style = _textStyle(lineInfo.color);
          final double minWidth =
              _textSize(text: text, style: style).width + 10;
          final double myWidth =
              constraints.maxWidth * (lineInfo.time / totalTime);

          if (minWidth < myWidth) {
            return _lineFlexible(
              text: text,
              style: style,
              color: lineInfo.color,
              flex: lineInfo.time,
            );
          } else {
            return _lineSizedBox(
              text: text,
              style: style,
              color: lineInfo.color,
              minWidth: minWidth,
            );
          }
        }).toList(),
      );
    }));
  }

  Flexible _lineFlexible({
    required String text,
    required TextStyle style,
    required Color? color,
    required int flex,
  }) {
    return Flexible(
      flex: flex,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(height / 2)),
            ),
            height: height,
          ),
          Transform.translate(
            offset: const Offset(0, 20),
            child: Text(
              text,
              maxLines: 1,
              style: style,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _lineSizedBox({
    required String text,
    required TextStyle style,
    required Color? color,
    required double minWidth,
  }) {
    return SizedBox(
      width: minWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(height / 2)),
            ),
            height: height,
          ),
          Transform.translate(
            offset: const Offset(0, 20),
            child: Text(
              text,
              maxLines: 1,
              style: style,
            ),
          ),
        ],
      ),
    );
  }

  Size _textSize({required String text, required TextStyle style}) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  TextStyle _textStyle(Color? color) {
    if (color != null) {
      return TextStyle(
        fontFamily: NanumSquare.extraBold,
        fontSize: 16,
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
