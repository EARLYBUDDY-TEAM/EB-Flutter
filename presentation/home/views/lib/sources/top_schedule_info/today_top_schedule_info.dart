part of '../../eb_home.dart';

final class _TodayTopScheduleInfoView extends StatelessWidget {
  final Schedule nextSchedule;

  final textColor = Colors.white;

  const _TodayTopScheduleInfoView({
    required this.nextSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _rowChildren,
      ),
    );
  }

  List<Widget> get _rowChildren {
    final List<Widget> content = [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _columnChildren,
      ),
    ];
    if (nextSchedule.startPlace != null) {
      content.add(_showRouteButton());
    }
    return content;
  }

  Widget _showRouteButton() {
    return EBRoundedButton(
      text: "  경로보기  ",
      fontSize: 20,
      height: 40,
      color: textColor,
      onPressed: () {},
    );
  }

  List<Widget> get _columnChildren {
    final List<Widget> content = [
      _prefixText(),
      _titleText(),
      const SizedBox(height: 10),
      _timeText(),
    ];
    if (nextSchedule.endPlace != null) {
      content.add(_endPlaceText(nextSchedule.endPlace!.name));
    }
    return content;
  }

  Widget _prefixText() {
    return Text(
      '다음일정',
      style: TextStyle(
        fontFamily: FontFamily.gmarketSansRegular,
        fontSize: 18,
        color: textColor,
      ),
    );
  }

  Widget _titleText() {
    return Text(
      nextSchedule.title,
      style: TextStyle(
        fontFamily: FontFamily.gmarketSansRegular,
        fontSize: 22,
        color: textColor,
      ),
    );
  }

  Widget _timeText() {
    final meridiemString = nextSchedule.time.toMeridiem();
    final hourString = nextSchedule.time.addZeroToHour();
    final minuteString = nextSchedule.time.addZeroToMinute();
    final text = "$meridiemString $hourString:$minuteString";

    return Text(
      text,
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        fontSize: 18,
        color: textColor,
      ),
    );
  }

  Widget _endPlaceText(String placeName) {
    return Text(
      placeName,
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        fontSize: 18,
        color: textColor,
      ),
    );
  }
}
