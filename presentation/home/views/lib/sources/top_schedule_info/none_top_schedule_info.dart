part of '../../eb_home.dart';

final class _NoneTopScheduleInfoView extends StatelessWidget {
  final Schedule? upcomingSchedule;

  final textColor = Colors.white;

  const _NoneTopScheduleInfoView({
    required this.upcomingSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _children,
        ),
      ),
    );
  }

  List<Widget> get _children {
    final List<Widget> listWidget = [_constText()];
    if (upcomingSchedule == null) {
      listWidget.add(const SizedBox(height: 40));
    } else {
      listWidget.add(const SizedBox(height: 10));
      listWidget.add(_divider());
      listWidget.add(const SizedBox(height: 10));
      listWidget.add(_timeText(upcomingSchedule!));
      listWidget.add(_titleText(upcomingSchedule!));
    }
    return listWidget;
  }

  Widget _constText() {
    return Text(
      "오늘은 등록된 일정이 없어요!",
      style: TextStyle(
        color: textColor,
        fontFamily: FontFamily.gmarketSansRegular,
        fontSize: 18,
      ),
    );
  }

  Widget _divider() {
    return Divider(
      color: textColor,
      thickness: 0.5,
    );
  }

  Widget _timeText(Schedule upcomingSchedule) {
    const prefixStirng = "다가오는 일정";
    final dateTime = upcomingSchedule.time;
    final dateString =
        "${dateTime.addZeroToMonth()}.${dateTime.addZeroToDay()}";
    final timeString =
        "${dateTime.addZeroToHour()}:${dateTime.addZeroToMinute()}";

    final text = "$prefixStirng $dateString $timeString";
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontFamily: FontFamily.gmarketSansLight,
        fontSize: 16,
      ),
    );
  }

  Widget _titleText(Schedule upcomingSchedule) {
    return Text(
      upcomingSchedule.title,
      style: TextStyle(
        color: textColor,
        fontFamily: FontFamily.gmarketSansRegular,
        fontSize: 22,
      ),
    );
  }
}
