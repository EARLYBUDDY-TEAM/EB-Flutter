part of '../../eb_home.dart';

final class MiddleTransportAddRoute extends StatelessWidget {
  final SchedulePath schedulePath;

  const MiddleTransportAddRoute({
    super.key,
    required this.schedulePath,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        backgroundColor: Colors.white,
        builder: builderModalBottomSheet(
          context: context,
          onGenerateRoute: FindRouteView.pageWriteAndUpdateFindRoute(
            context: context,
            schedulePath: schedulePath,
            startPlace: null,
            endPlace: null,
            pageChangeStartPlace: SearchPlaceView.pageChangeStartPlace,
            pageChangeEndPlace: SearchPlaceView.pageChangeEndPlace,
          ),
        ),
      ),
      child: const _MiddleTransportAdd(
        text: "경로 추가하기",
      ),
    );
  }
}

final class MiddleTransportAddSchedule extends StatelessWidget {
  const MiddleTransportAddSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).push(
        AddScheduleView.pageInitAddSchedule(context: context),
      ),
      child: const _MiddleTransportAdd(
        text: "일정 추가하기",
      ),
    );
  }
}

final class _MiddleTransportAdd extends StatelessWidget {
  final String text;

  const _MiddleTransportAdd({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "+ $text",
      style: TextStyle(
        fontFamily: FontFamily.gmarketSansRegular,
        color: EBColors.blue3,
        fontSize: 24,
      ),
    );
  }
}
