part of '../../selectroute_view.dart';

final class _SelectRouteSortView extends StatelessWidget {
  const _SelectRouteSortView();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.grey.shade100,
      child: Row(
        children: [
          Column(
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
