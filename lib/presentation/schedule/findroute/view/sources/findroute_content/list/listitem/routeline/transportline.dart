part of '../../../../findroute_view.dart';

class _TransportLine extends StatelessWidget {
  final double height;

  const _TransportLine({required height}) : height = height + 3;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _line(name: '50분', flex: 2, color: null),
        _line(name: '2호선', flex: 3, color: Colors.green),
        _line(name: '20분', flex: 1, color: null),
        _line(name: '350', flex: 4, color: Colors.blue),
      ],
    );
  }

  Flexible _line({
    required String name,
    required int flex,
    required Color? color,
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
              name,
              style: _textStyle(color),
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
