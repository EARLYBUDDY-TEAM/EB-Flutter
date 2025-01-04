part of '../../eb_home.dart';

final class _MiddleTransportView extends StatelessWidget {
  final double horizontalPadding;

  const _MiddleTransportView({
    super.key,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, MiddleTransportInfoState>(
      selector: (state) => state.middleTransportInfoState,
      builder: (context, middleState) {
        final todayCloseSchedulePath = middleState.todayCloseSchedulePath;
        return _MiddleTransportBlocView(
          schedulePath: todayCloseSchedulePath,
          horizontalPadding: horizontalPadding,
        );
      },
    );
  }
}

final class _MiddleTransportBlocView extends StatefulWidget {
  final SchedulePath? schedulePath;
  final double horizontalPadding;

  const _MiddleTransportBlocView({
    super.key,
    required this.schedulePath,
    required this.horizontalPadding,
  });

  @override
  State<StatefulWidget> createState() => _MiddleTransportBlocViewState();
}

final class _MiddleTransportBlocViewState
    extends State<_MiddleTransportBlocView> {
  MiddleTranportBloc? bloc;

  @override
  void didUpdateWidget(covariant _MiddleTransportBlocView oldWidget) {
    if ((oldWidget.schedulePath != widget.schedulePath) && (bloc != null)) {
      bloc!.add(SetupMiddleTransport(schedulePath: widget.schedulePath));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MiddleTranportBloc>(
      create: (context) {
        final realTimeInfoEvent = RealTimeInfoEvent(
          homeRepository: RepositoryProvider.of<HomeRepositoryAB>(context),
        );

        final tmpBloc = MiddleTranportBloc(
          realTimeInfoEvent: realTimeInfoEvent,
        )..add(
            SetupMiddleTransport(schedulePath: widget.schedulePath),
          );
        bloc = tmpBloc;
        return tmpBloc;
      },
      child: _MiddleTransportCardContent(
        horizontalPadding: widget.horizontalPadding,
      ),
    );
  }
}

final class _MiddleTransportCardContent extends StatelessWidget {
  final double horizontalPadding;
  double cardHeight(double height) {
    return height + 20;
  }

  const _MiddleTransportCardContent({
    super.key,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight(160),
      child: BlocSelector<MiddleTranportBloc, MiddleTransportState,
          SealedMiddleTransportViewState>(
        selector: (state) => state.viewState,
        builder: (context, viewState) {
          switch (viewState) {
            case AddRouteMiddleTransportState():
              final schedulePath = viewState.schedulePath;
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 20,
                ),
                child: MiddleTransportAddRouteCard(schedulePath: schedulePath),
              );
            case AddScheduleMiddleTransportState():
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 20,
                ),
                child: const MiddleTransportAddScheduleCard(),
              );
            case InfoMiddleTransportViewState():
              final cardStateList = viewState.cardStateList;
              final currentIndex = viewState.currentIndex;
              final streamBusRealTimeInfo = viewState.streamRealTimeInfo;

              return MiddleTransportInfoView(
                currentIndex: currentIndex,
                streamRealTimeInfo: streamBusRealTimeInfo,
                cardStateList: cardStateList,
                horizontalPadding: horizontalPadding,
              );
          }
        },
      ),
    );
  }
}
