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
        child: BlocSelector<FindRouteBloc, FindRouteState, FindRouteStatus>(
          selector: (state) {
            return state.status;
          },
          builder: (context, status) {
            return Row(
              children: _content(status),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _content(FindRouteStatus status) {
    List<Widget> content = [
      _arrivalInfo(),
      const Spacer(),
    ];

    if (status == FindRouteStatus.detailRoute) {
      content.add(_pathInfo());
    }

    return content;
  }

  Widget _pathInfo() {
    return DefaultTextStyle(
      style: TextStyle(fontFamily: NanumSquare.bold, color: EBColors.text),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('버스 + 지하철'),
          SizedBox(height: 10),
          Text(
            '1시간 30분',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrivalInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _date(),
        const SizedBox(height: 3),
        _hour(),
      ],
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
