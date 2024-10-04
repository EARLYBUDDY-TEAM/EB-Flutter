part of '../../eb_home.dart';

final class BottomScheduleCardView extends StatelessWidget {
  final ScheduleCard scheduleCard;

  const BottomScheduleCardView({
    super.key,
    required this.scheduleCard,
  });

  @override
  Widget build(BuildContext context) {
    return RoundRectForm(
      borderRadius: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: Row(
          children: [
            _circleDot(),
            const SizedBox(width: 10),
            _titleAndPlace(),
            const SizedBox(width: 10),
            _scheduleTime(),
          ],
        ),
      ),
    );
  }

  Widget _circleDot() {
    return Icon(
      Icons.trip_origin,
      size: 12,
      color: EBColors.blue3,
    );
  }

  Widget _titleAndPlace() {
    List<Widget> widgetList = [_titleText()];
    if (scheduleCard.endPlaceName != null) {
      widgetList.add(_endPlaceName());
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgetList,
      ),
    );
  }

  Widget _titleText() {
    return Text(
      scheduleCard.title,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontFamily: FontFamily.gmarketSansRegular,
        fontSize: 16,
      ),
    );
  }

  Widget _endPlaceName() {
    return Text(
      scheduleCard.endPlaceName!,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        color: Colors.black54,
      ),
    );
  }

  Widget _scheduleTime() {
    final timeOfDay = EBTime.dateTimeToTimeOfDay(scheduleCard.time);
    final text = EBTime.toHour(timeOfDay);
    return Text(
      text,
      style: const TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        color: Colors.black54,
      ),
    );
  }
}