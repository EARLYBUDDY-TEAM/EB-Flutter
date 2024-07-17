part of '../../findroute_view.dart';

final class _FindRouteSortView extends StatelessWidget {
  final double height;

  const _FindRouteSortView({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _date(),
                const SizedBox(height: 3),
                _hour(),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Text _date() {
    return const Text(
      '12월 21일 (토요일)',
      style: TextStyle(
        color: Colors.black54,
        fontFamily: NanumSquare.bold,
        fontSize: 15,
      ),
    );
  }

  RichText _hour() {
    return RichText(
      text: TextSpan(
        text: '오전 12:20',
        style: TextStyle(
          color: EBColors.blue2,
          fontFamily: NanumSquare.extraBold,
          fontSize: 19,
        ),
        children: const [
          TextSpan(
            text: ' 도착',
            style: TextStyle(
              color: Colors.black54,
              fontFamily: NanumSquare.extraBold,
              fontSize: 19,
            ),
          )
        ],
      ),
    );
  }
}
