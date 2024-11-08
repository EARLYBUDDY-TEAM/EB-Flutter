part of '../../../eb_home.dart';

final class MiddleTransportAddRouteCard extends StatelessWidget {
  final SchedulePath schedulePath;

  const MiddleTransportAddRouteCard({
    super.key,
    required this.schedulePath,
  });

  @override
  Widget build(BuildContext context) {
    return MiddleTransportCardForm(
      child: TextButton(
        child: const _MiddleTransportAddCardContent(
          text: "경로 추가하기",
        ),
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
      ),
    );
  }
}

final class MiddleTransportAddScheduleCard extends StatelessWidget {
  const MiddleTransportAddScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddleTransportCardForm(
      child: TextButton(
        onPressed: () => Navigator.of(context).push(
          AddScheduleView.pageInitAddSchedule(context: context),
        ),
        child: const _MiddleTransportAddCardContent(
          text: "일정 추가하기",
        ),
      ),
    );
  }
}

final class _MiddleTransportAddCardContent extends StatelessWidget {
  final String text;

  const _MiddleTransportAddCardContent({
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
