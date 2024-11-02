part of '../../eb_home.dart';

final class _MiddleTransportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, SealedMiddleTransportState>(
      selector: (state) => state.middleTransportInfoState,
      builder: (context, middleState) {
        Widget content;
        switch (middleState) {
          case AddRouteMiddleTransportState():
            final schedulePath = middleState.schedulePath;
            content = MiddleTransportAddRoute(schedulePath: schedulePath);
          case AddScheduleMiddleTransportState():
            content = const MiddleTransportAddSchedule();
          case InfoMiddleTransportState():
            final stream = middleState.realTimeInfoStream;
            final subPath = middleState.subPath;
            content = MiddleTransportInfo(
              subPath: subPath,
              stream: stream,
            );
          case OverScheduleMiddleTransportState():
            content = const MiddleTransportOverSchedule();
          case ArrivalMiddleTransportState():
            content = const MiddleTransportArrival();
        }
        return MiddleTransportForm(
          content: content,
        );
      },
    );
  }
}

final class MiddleTransportForm extends StatelessWidget {
  final Widget content;

  const MiddleTransportForm({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: content,
      ),
    );
  }
}
