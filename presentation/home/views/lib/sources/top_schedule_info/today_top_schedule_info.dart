part of '../../eb_home.dart';

final class _TodayTopScheduleInfoView extends StatelessWidget {
  final Schedule schedule;
  final EBPath? ebPath;

  final textColor = Colors.white;

  _TodayTopScheduleInfoView({
    required SchedulePath nextSchedulePath,
  })  : schedule = nextSchedulePath.schedule,
        ebPath = nextSchedulePath.ebPath;

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
    if (schedule.startPlace != null) {
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
    if (schedule.endPlace != null) {
      content.add(_endPlaceText(schedule.endPlace!.name));
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
      schedule.title,
      style: TextStyle(
        fontFamily: FontFamily.gmarketSansRegular,
        fontSize: 22,
        color: textColor,
      ),
    );
  }

  Widget _timeText() {
    final meridiemString = schedule.time.toMeridiem();
    final hourString = schedule.time.addZeroToHour();
    final minuteString = schedule.time.addZeroToMinute();
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
