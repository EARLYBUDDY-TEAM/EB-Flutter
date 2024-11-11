part of '../../middle_transport_feature.dart';

final class MiddleTranportBloc
    extends Bloc<MiddleTransportEvent, MiddleTransportState> {
  final HomeRepositoryAB _homeRepository;

  BehaviorSubject<EBSubPath>? _realTimeInfoSubject;
  StreamSubscription<dynamic>? _timerSubscription;

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
  Future<RealTimeInfoMap> getRealTimeInfo({
    required EBSubPath subPath,
  }) async {
    final stationID = subPath.startStationID;
    if (stationID == null) {
      return {};
    }

    final type = subPath.type;
    Result result;
    switch (type) {
      case 1:
        result =
            await _homeRepository.getSubwayRealTimeInfo(stationID: stationID);
      case 2:
        result = await _homeRepository.getBusRealTimeInfo(stationID: stationID);
      default:
        return {};
    }

    switch (result) {
      case Success():
        final RealTimeInfoMap realTimeInfoList = result.success.model;
        return realTimeInfoList;

      case Failure():
        return {};
    }
  }

  Future<void> _tearDownStream() async {
    await _realTimeInfoSubject?.close().then((_) {
      _realTimeInfoSubject = null;
    });

    await _timerSubscription?.cancel().then((_) {
      _timerSubscription = null;
    });
  }

  Future<Stream<RealTimeInfoMap>> _makeStreamRealTimeInfo({
    required EBSubPath subPath,
  }) async {
    await _tearDownStream();

    final newRealTimeInfoSubject = BehaviorSubject<EBSubPath>.seeded(subPath);
    _realTimeInfoSubject = newRealTimeInfoSubject;

    final streamRealtimeInfo = _realTimeInfoSubject!.flatMap(
      (subPath) async* {
        final fetchedRealTimeInfo = await getRealTimeInfo(subPath: subPath);
        yield fetchedRealTimeInfo;
      },
    );

    _timerSubscription =
        Stream.periodic(const Duration(seconds: 15)).listen((_) {
      if (_realTimeInfoSubject != null) {
        _realTimeInfoSubject!.add(subPath);
      }
    });

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

  Future<SealedMiddleTransportViewState> initMiddleTransportViewState({
    required SchedulePath? schedulePath,
  }) async {
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
    final streamRealTimeInfo = await _makeStreamRealTimeInfo(
      subPath: curInfoMiddleTransportCardState.subPath,
    );

    return InfoMiddleTransportState(
      currentIndex: currentIndex,
      cardStateList: cardStateList,
      streamRealTimeInfo: streamRealTimeInfo,
    );
  }

  Future<void> _onSetupMiddleTransport(
    SetupMiddleTransport event,
    Emitter<MiddleTransportState> emit,
  ) async {
    final schedulePath = event.schedulePath;
    final viewState =
        await initMiddleTransportViewState(schedulePath: schedulePath);
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

    if (_realTimeInfoSubject == null) {
      return;
    }

    final subPath = viewState.cardStateList[event.selectedIndex].subPath;
    _realTimeInfoSubject!.add(subPath);
  }
}

extension on MiddleTranportBloc {
  Future<void> _onChangeTransportInfoCard(
    ChangeTransportInfoCard event,
    Emitter<MiddleTransportState> emit,
  ) async {
    final viewState = state.viewState;

    if (viewState is! InfoMiddleTransportState) {
      return;
    }

    final currentIndex = event.expectIndex;
    final subPath = viewState.cardStateList[currentIndex].subPath;
    final streamRealTimeInfo = await _makeStreamRealTimeInfo(subPath: subPath);
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
