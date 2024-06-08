part of '../../selectroute_view.dart';

final class _SelectRouteSortView extends StatelessWidget {
  const _SelectRouteSortView();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.5)),
          bottom: BorderSide(color: Colors.grey.withOpacity(0.5)),
        ),
      ),
      child: Container(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _date(),
                  _hour(),
                ],
              ),
              const Spacer(),
            ],
          ),
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
        fontSize: 18,
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
          fontSize: 22,
        ),
        children: const [
          TextSpan(
            text: ' 도착',
            style: TextStyle(
              color: Colors.black54,
              fontFamily: NanumSquare.extraBold,
              fontSize: 22,
            ),
          )
        ],
      ),
    );
  }
}
