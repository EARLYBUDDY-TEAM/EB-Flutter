part of '../../middle_transport_feature.dart';

final class MiddleTranportBloc
    extends Bloc<MiddleTransportEvent, MiddleTransportState> {
  final HomeRepositoryAB _homeRepository;

  late BehaviorSubject<EBSubPath> _realTimeInfoSubject;

  MiddleTranportBloc({
    required HomeRepositoryAB homeRepository,
  })  : _homeRepository = homeRepository,
        super(MiddleTransportState()) {
    on<SetupMiddleTransport>(_onSetupMiddleTransport);
    on<SelectTransport>(_onSelectTransport);
    on<PressReloadButton>(
      _onPressReloadButton,
      transformer: _throttle(),
    );
    on<ChangeTransportInfoCard>(
      _onChangeTransportInfoCard,
      transformer: _debounce(),
    );
  }
}

extension on MiddleTranportBloc {
  Future<RealTimeInfo?> getRealTimeInfo({
    required EBSubPath subPath,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return RealTimeInfo.mock();

    // final type = subPath.type;
    // Result result;
    // switch (type) {
    //   case 1:
    //     const stationID = 0;
    //     result =
    //         await _homeRepository.getSubwayRealTimeInfo(stationID: stationID);
    //   case 2:
    //     const stationID = 0;
    //     result = await _homeRepository.getBusRealTimeInfo(stationID: stationID);
    //   default:
    //     return null;
    // }

    // switch (result) {
    //   case Success():
    //     return result.success.model;
    //   case Failure():
    //     return null;
    // }
  }

  Stream<RealTimeInfo?> _makeStreamRealTimeInfo({
    required EBSubPath subPath,
  }) {
    _realTimeInfoSubject = BehaviorSubject<EBSubPath>.seeded(subPath);

    final streamRealtimeInfo = _realTimeInfoSubject.flatMap(
      (subPath) async* {
        final fetchedRealTimeInfo = await getRealTimeInfo(subPath: subPath);
        yield fetchedRealTimeInfo;
      },
    );

    var stream = Stream.periodic(const Duration(seconds: 15));
    stream.listen((_) => _realTimeInfoSubject.add(subPath));

    return streamRealtimeInfo;
  }
}

extension on MiddleTranportBloc {
  Transport? getSelectedTransport({
    required EBSubPath subPath,
  }) {
    return subPath.transportList.firstOrNull;
  }

  List<InfoMiddleTransportCardState> makeCardStateList({
    required DateTime scheduleTime,
    required EBPath ebPath,
  }) {
    var flagTotalTime = ebPath.time;
    var flagStartTime = scheduleTime.subtract(Duration(minutes: ebPath.time));
    final tmpList = ebPath.ebSubPathList.map<InfoMiddleTransportCardState>(
      (s) {
        final subPath = s;
        final expectStartTime = flagStartTime;
        flagStartTime = flagStartTime.add(Duration(minutes: s.time));
        final expectTotalTime = flagTotalTime;
        flagTotalTime -= s.time;
        final selectedTransport = getSelectedTransport(subPath: s);

        return InfoMiddleTransportCardState(
          selectedTransport: selectedTransport,
          subPath: subPath,
          expectStartTime: expectStartTime,
          expectTotalMinute: expectTotalTime,
        );
      },
    ).where(
      (s) {
        return (s.subPath.type != 3);
      },
    ).toList();

    return tmpList;
  }

  int getCurrentIndex({
    required List<InfoMiddleTransportCardState> cardStateList,
  }) {
    var currentIndex = 0;
    for (int i = 1; i < cardStateList.length; i++) {
      final curStartExpectTime = cardStateList[i].expectStartTime;
      final compareDateResult =
          EBTime.compare(left: DateTime.now(), right: curStartExpectTime);

      if (compareDateResult == CompareDateResult.left) {
        break;
      }

      currentIndex = i;
    }

    currentIndex = 0;

    return currentIndex;
  }

  SealedMiddleTransportViewState initMiddleTransportViewState({
    required SchedulePath? schedulePath,
  }) {
    if (schedulePath == null) {
      return AddScheduleMiddleTransportState();
    }

    final ebPath = schedulePath.ebPath;
    if (ebPath == null) {
      return AddRouteMiddleTransportState(schedulePath: schedulePath);
    }

    final cardStateList = makeCardStateList(
      ebPath: ebPath,
      scheduleTime: schedulePath.schedule.time,
    );

    if (cardStateList.isEmpty) {
      return AddScheduleMiddleTransportState();
    }

    final currentIndex = getCurrentIndex(
      cardStateList: cardStateList,
    );
    final curInfoMiddleTransportCardState = cardStateList[currentIndex];
    final streamRealTimeInfo = _makeStreamRealTimeInfo(
      subPath: curInfoMiddleTransportCardState.subPath,
    );

    return InfoMiddleTransportState(
      currentIndex: currentIndex,
      cardStateList: cardStateList,
      streamRealTimeInfo: streamRealTimeInfo,
    );
  }

  void _onSetupMiddleTransport(
    SetupMiddleTransport event,
    Emitter<MiddleTransportState> emit,
  ) {
    final schedulePath = event.schedulePath;
    final viewState = initMiddleTransportViewState(schedulePath: schedulePath);
    emit(state.copyWith(viewState: viewState));
  }
}

extension on MiddleTranportBloc {
  void _onSelectTransport(
    SelectTransport event,
    Emitter<MiddleTransportState> emit,
  ) {
    final viewState = state.viewState;

    if (viewState is! InfoMiddleTransportState) {
      return;
    }
    final newViewState = viewState.copyWith(
      currentIndex: event.selectedIndex,
      reloadTrigger: !viewState.reloadTrigger,
    );
    final cardState = newViewState.cardStateList[event.selectedIndex];
    final newCardState = cardState.copyWith(
      selectedTransport: () => event.selectedTransport,
    );

    newViewState.cardStateList[event.selectedIndex] = newCardState;
    emit(state.copyWith(viewState: newViewState));
  }
}

extension on MiddleTranportBloc {
  EventTransformer<Event> _throttle<Event>({
    Duration duration = const Duration(seconds: 3),
  }) {
    return (events, mapper) => events.throttleTime(duration).switchMap(mapper);
  }

  void _onPressReloadButton(
    PressReloadButton event,
    Emitter<MiddleTransportState> emit,
  ) {
    final viewState = state.viewState;
    if (viewState is! InfoMiddleTransportState) {
      return;
    }

    final subPath = viewState.cardStateList[event.selectedIndex].subPath;
    _realTimeInfoSubject.add(subPath);
  }
}

extension on MiddleTranportBloc {
  void _onChangeTransportInfoCard(
    ChangeTransportInfoCard event,
    Emitter<MiddleTransportState> emit,
  ) {
    final viewState = state.viewState;

    if (viewState is! InfoMiddleTransportState) {
      return;
    }

    final currentIndex = event.expectIndex;

    final subPath = viewState.cardStateList[currentIndex].subPath;
    final streamRealTimeInfo = _makeStreamRealTimeInfo(subPath: subPath);
    final newViewState = viewState.copyWith(
      currentIndex: currentIndex,
      streamRealTimeInfo: streamRealTimeInfo,
    );

    emit(state.copyWith(viewState: newViewState));
  }

  EventTransformer<Event> _debounce<Event>({
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }
}
