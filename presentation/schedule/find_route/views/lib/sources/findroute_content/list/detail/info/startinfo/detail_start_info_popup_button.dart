part of '../../../../../../eb_find_route.dart';

final class _DetailStartInfoPopupButton extends StatelessWidget {
  final String transNumber;
  final Color color;
  final String startName;
  final double fontSize;

  const _DetailStartInfoPopupButton({
    super.key,
    required this.transNumber,
    required this.color,
    required this.startName,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          log("checkckckck");
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _startInfo(),
            const SizedBox(height: 5),
            _realTimeInfo(),
          ],
        ),
      ),
    );
  }

  Widget _startInfo() {
    return Row(
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
            fontFamily: FontFamily.nanumSquareBold,
            fontSize: fontSize,
            color: EBColors.text,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _realTimeInfo() {
    return Text(
      "14분 후, 28분 후",
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        fontSize: 15,
        color: EBColors.error,
      ),
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
            fontFamily: FontFamily.nanumSquareExtraBold,
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
