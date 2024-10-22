part of '../../eb_home.dart';

final class BottomScheduleCardView extends StatelessWidget {
  final Schedule schedule;

  const BottomScheduleCardView({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: RoundRectForm(
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
      ),
      onTap: () => showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        backgroundColor: Colors.white,
        builder: builderModalBottomSheet(
          context: context,
          onGenerateRoute:
              AddScheduleView.pageAddScheduleView(context: context),
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
    if (schedule.endPlace?.name != null) {
      widgetList.add(_endPlaceText(name: schedule.endPlace!.name));
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
      schedule.title,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontFamily: FontFamily.gmarketSansRegular,
        fontSize: 16,
      ),
    );
  }

  Widget _endPlaceText({
    required String name,
  }) {
    return Text(
      name,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        color: Colors.black54,
      ),
    );
  }

  Widget _scheduleTime() {
    final timeOfDay = EBTime.dateTimeToTimeOfDay(schedule.time);
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
