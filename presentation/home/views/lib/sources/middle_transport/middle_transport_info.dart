part of '../../eb_home.dart';

final class MiddleTransportInfo extends StatelessWidget {
  const MiddleTransportInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _leftTranportColumn(),
        _rightDispatchColumn(),
      ],
    );
  }

  Widget _leftTranportColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(
                  '강남06',
                  style: TextStyle(
                    fontFamily: FontFamily.nanumSquareBold,
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(
              '삼성의료원 후문',
              style: TextStyle(
                fontFamily: FontFamily.nanumSquareRegular,
                color: Colors.black87,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const Text(
          '버스 도착까지',
          style: TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Text(
              '약속장소에 ',
              style: TextStyle(
                fontFamily: FontFamily.gmarketSansRegular,
                color: Colors.black87,
              ),
            ),
            Text(
              '14:20',
              style: TextStyle(
                fontFamily: FontFamily.gmarketSansBold,
                color: Colors.blue,
              ),
            ),
            Text(
              ' 도착 예정',
              style: TextStyle(
                fontFamily: FontFamily.gmarketSansRegular,
                color: Colors.black87,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _rightDispatchColumn() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '12분 전',
          style: TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            fontSize: 35,
          ),
        ),
        Text(
          '다음 배차까지 25분전',
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareRegular,
            color: Colors.black87,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
