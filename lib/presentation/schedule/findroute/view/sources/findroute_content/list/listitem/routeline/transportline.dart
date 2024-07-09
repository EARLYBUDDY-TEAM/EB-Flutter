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
    return LayoutBuilder(builder: ((context, constraints) {
      return Row(
          children: lineOfPath.lineOfPath.map((lineInfo) {
        final String text = lineInfo.name ?? '${lineInfo.subPathTime}분';
        final TextStyle style = _textStyle(lineInfo.color);
        final double minWidth = _textSize(text: text, style: style).width + 10;
        final double myWidth =
            constraints.maxWidth * (lineInfo.subPathTime / lineOfPath.pathTime);

        if (minWidth < myWidth) {
          return _lineFlexible(lineInfo: lineInfo);
        } else {
          return _lineSizedBox(lineInfo: lineInfo, width: minWidth);
        }
      }).toList());
    }));
  }

  Flexible _lineFlexible({
    required TransportLineInfo lineInfo,
  }) {
    final String text = lineInfo.name ?? '${lineInfo.subPathTime}분';
    final TextStyle style = _textStyle(lineInfo.color);

    return Flexible(
      flex: lineInfo.subPathTime,
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
    required TransportLineInfo lineInfo,
    required double width,
  }) {
    final String text = lineInfo.name ?? '${lineInfo.subPathTime}분';
    final TextStyle style = _textStyle(lineInfo.color);

    return SizedBox(
      width: width,
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
