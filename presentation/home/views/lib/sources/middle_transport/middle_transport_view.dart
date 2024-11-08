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
        return _MiddleTransportStateful(
          schedulePath: todayCloseSchedulePath,
          horizontalPadding: horizontalPadding,
        );
      },
    );
  }
}

final class _MiddleTransportStateful extends StatefulWidget {
  final SchedulePath? schedulePath;
  final double horizontalPadding;

  const _MiddleTransportStateful({
    super.key,
    required this.schedulePath,
    required this.horizontalPadding,
  });

  @override
  State<StatefulWidget> createState() => _MiddleTransportViewState();
}

final class _MiddleTransportViewState extends State<_MiddleTransportStateful> {
  late MiddleTranportBloc bloc;
  var isFirst = true;

  @override
  Widget build(BuildContext context) {
    if (!isFirst) {
      bloc.add(SetupMiddleTransport(schedulePath: widget.schedulePath));
    }

    return BlocProvider<MiddleTranportBloc>(
      create: (context) {
        final tmpBloc = MiddleTranportBloc(
          homeRepository: RepositoryProvider.of<HomeRepositoryAB>(context),
        )..add(SetupMiddleTransport(schedulePath: widget.schedulePath));
        bloc = tmpBloc;
        isFirst = false;
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

  const _MiddleTransportCardContent({
    super.key,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: BlocSelector<MiddleTranportBloc, MiddleTransportState,
          MiddleTransportViewState>(
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
            case InfoMiddleTransportState():
              final cardStateList = viewState.cardStateList;
              final currentIndex = viewState.currentIndex;
              final streamRealTimeInfo = viewState.streamRealTimeInfo;

              return MiddleTransportInfoView(
                currentIndex: currentIndex,
                streamRealTimeInfo: streamRealTimeInfo,
                cardStateList: cardStateList,
                horizontalPadding: horizontalPadding,
              );
          }
        },
      ),
    );
  }
}
