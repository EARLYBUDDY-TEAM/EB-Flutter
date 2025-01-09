part of '../../middle_transport_feature.dart';

final class MiddleTranportBloc
    extends Bloc<MiddleTransportEvent, MiddleTransportState> {
  final RealTimeInfoEvent _realTimeInfoEvent;
  final MiddleTransportScheduler _middleTransportScheduler;

  MiddleTranportBloc({
    required RealTimeInfoEvent realTimeInfoEvent,
    MiddleTransportScheduler? middleTransportScheduler,
  })  : _realTimeInfoEvent = realTimeInfoEvent,
        _middleTransportScheduler =
            middleTransportScheduler ?? MiddleTransportScheduler(),
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
    on<OnTapMiddleTransportImminentCard>(
      _onOnTapMiddleTransportImminentCard,
    );
    on<MiddleTransportSchedulerAction>(
      _onMiddleTransportSchedulerAction,
    );
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
    var flagTotalMinute = ebPath.time;
    var flagStartTime = scheduleTime.subtract(Duration(minutes: ebPath.time));
    final cardStateList =
        ebPath.ebSubPathList.map<InfoMiddleTransportCardState>(
      (s) {
        final expectStartTime = flagStartTime;
        flagStartTime = flagStartTime.add(Duration(minutes: s.time));
        final expectTotalMinute = flagTotalMinute;
        flagTotalMinute -= s.time;
        final subPath = s;
        final selectedTransport = getSelectedTransport(subPath: subPath);

        final cardState = InfoMiddleTransportCardState(
          selectedTransport: selectedTransport,
          expectStartTime: expectStartTime,
          expectTotalMinute: expectTotalMinute,
          subPath: subPath,
        );

        return cardState;
      },
    ).where(
      (s) {
        return (s.subPath.type != 3);
      },
    ).toList();

    return cardStateList;
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
    final subPath = cardStateList[currentIndex].subPath;
    final streamRealTimeInfo =
        await _realTimeInfoEvent.makeStreamRealTimeInfo(subPath: subPath);

    final imminentState = getImminentState(
      scheduleTime: schedulePath.schedule.time,
      now: DateTime.now(),
    );

    return InfoMiddleTransportViewState(
      currentIndex: currentIndex,
      cardStateList: cardStateList,
      streamRealTimeInfo: streamRealTimeInfo,
      imminentCardState: ImminentCardState(
        scheduleTime: schedulePath.schedule.time,
        imminentState: imminentState,
      ),
    );
  }

  Future<void> _setupMiddleTransportScheduler({
    required SealedMiddleTransportViewState viewState,
  }) async {
    await _middleTransportScheduler.tearDown();
    if (viewState is InfoMiddleTransportViewState) {
      _middleTransportScheduler.start(
        action: () {
          add(MiddleTransportSchedulerAction());
        },
      );
    }
  }

  Future<void> _onSetupMiddleTransport(
    SetupMiddleTransport event,
    Emitter<MiddleTransportState> emit,
  ) async {
    final schedulePath = event.schedulePath;
    final viewState =
        await initMiddleTransportViewState(schedulePath: schedulePath);
    emit(state.copyWith(viewState: viewState));
    await _setupMiddleTransportScheduler(viewState: viewState);
  }
}

extension on MiddleTranportBloc {
  void _onSelectTransport(
    SelectTransport event,
    Emitter<MiddleTransportState> emit,
  ) {
    final viewState = state.viewState;

    if (viewState is! InfoMiddleTransportViewState) {
      return;
    }

    final index = event.selectedIndex;
    final newViewState = viewState.copyWith(
      currentIndex: index,
      reloadTrigger: !viewState.reloadTrigger,
    );
    final curCardState = newViewState.cardStateList[index];
    final newCardState = curCardState.copyWith(
      selectedTransport: () => event.selectedTransport,
    );
    newViewState.cardStateList[index] = newCardState;

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
    if (viewState is! InfoMiddleTransportViewState) {
      return;
    }

    final index = event.selectedIndex;
    final curCardState = viewState.cardStateList[index];
    final subPath = curCardState.subPath;
    _realTimeInfoEvent.reloadRealTimeInfo(subPath: subPath);
  }
}

extension on MiddleTranportBloc {
  Future<void> _onChangeTransportInfoCard(
    ChangeTransportInfoCard event,
    Emitter<MiddleTransportState> emit,
  ) async {
    final viewState = state.viewState;

    if (viewState is! InfoMiddleTransportViewState) {
      return;
    }

    final index = event.expectIndex;
    final cardStateList = viewState.cardStateList;
    if (index == cardStateList.length) {
      final newViewState = viewState.copyWith(
        currentIndex: index,
        streamRealTimeInfo: () => null,
      );
      emit(state.copyWith(viewState: newViewState));
      return;
    }

    final subPath = cardStateList[index].subPath;
    final streamRealTimeInfo =
        await _realTimeInfoEvent.makeStreamRealTimeInfo(subPath: subPath);
    final newViewState = viewState.copyWith(
      currentIndex: index,
      streamRealTimeInfo: () => streamRealTimeInfo,
    );

    final curCardState = cardStateList[index];
    final expectStartTime = curCardState.expectStartTime;
    final expectTotalTime = curCardState.expectTotalMinute;
    log("index : $index");
    log("expectStartTime: $expectStartTime");
    log("expectTotalTime: $expectTotalTime");

    emit(state.copyWith(viewState: newViewState));
  }

  EventTransformer<Event> _debounce<Event>({
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }
}

extension on MiddleTranportBloc {
  void _onOnTapMiddleTransportImminentCard(
    OnTapMiddleTransportImminentCard event,
    Emitter<MiddleTransportState> emit,
  ) {
    final viewState = state.viewState;
    if (viewState is! InfoMiddleTransportViewState) {
      return;
    }

    final newImminentCardState = viewState.imminentCardState.copyWith(
      onTapImminentCard: !viewState.imminentCardState.onTapImminentCard,
    );

    final newViewState = viewState.copyWith(
      imminentCardState: newImminentCardState,
    );
    emit(state.copyWith(viewState: newViewState));
  }
}

extension on MiddleTranportBloc {
// notImminent : 일정 많이 남은경우
// imminent : 일정 10분전
// overSchedule : 일정시간을 넘은 경우
  ImminentState getImminentState({
    required DateTime scheduleTime,
    required DateTime now,
  }) {
    final compareDateResult = EBTime.compare(
      left: now,
      right: scheduleTime,
    );
    if (compareDateResult == CompareDateResult.left) {
      return ImminentState.overSchedule;
    }
    var diff = scheduleTime.difference(now).inMinutes;
    if (diff < 0) {
      diff *= -1;
    }
    log("diff : $diff");
    return (diff <= 10) ? ImminentState.imminent : ImminentState.notImminent;
  }

  void _onMiddleTransportSchedulerAction(
    MiddleTransportSchedulerAction event,
    Emitter<MiddleTransportState> emit,
  ) {
    final viewState = state.viewState;
    if (viewState is! InfoMiddleTransportViewState) {
      return;
    }

    final scheduleTime = viewState.imminentCardState.scheduleTime;
    final now = DateTime.now();
    final imminentState = getImminentState(
      scheduleTime: scheduleTime,
      now: now,
    );
    final newImminentCardState = viewState.imminentCardState.copyWith(
      imminentState: imminentState,
    );
    final newViewState = viewState.copyWith(
      imminentCardState: newImminentCardState,
    );
    emit(state.copyWith(viewState: newViewState));
  }
}
