part of '../../findroute_view.dart';

final class _FindRouteInfoView extends StatelessWidget {
  final double horizontalInset = 15;

  const _FindRouteInfoView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: horizontalInset, right: horizontalInset, bottom: 20),
      child: Row(
        children: [
          infoImage(),
          SizedBox(width: horizontalInset),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _departure(),
                _divider(),
                _arrival(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container infoImage() {
    return Container(
      width: 25,
      height: 60,
      color: Colors.amber,
    );
  }

  Row _departure() {
    return Row(
      children: [
        Text(
          '스타벅스 리저브 수서역 R점',
          style: TextStyle(
            fontFamily: NanumSquare.bold,
            color: EBColors.text,
            fontSize: 15,
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 25,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              side: const BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: const Text(
              '변경',
              style: TextStyle(
                fontFamily: NanumSquare.bold,
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ),
        )
      ],
    );
  }

  Divider _divider() {
    return Divider(
      color: Colors.grey.withOpacity(0.5),
      thickness: 1,
    );
  }

  Text _arrival() {
    return Text(
      '충무로역',
      style: TextStyle(
        fontFamily: NanumSquare.extraBold,
        color: Colors.grey.withOpacity(0.7),
        fontSize: 15,
      ),
    );
  }
}