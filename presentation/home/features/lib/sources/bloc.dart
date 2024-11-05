part of '../eb_home_feature.dart';

final class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadingDelegate _loadingDelegate;
  final HomeRepositoryAB _homeRepository;
  final TokenEvent _tokenEvent;
  final ScheduleEvent _scheduleEvent;

  final Function() _cancelModalViewAction;

  late StreamSubscription<BaseStatus> _loginStatusSubscription;
  late StreamSubscription<BaseStatus> _registerStatusSubscription;
  late StreamSubscription<void> _getAllSchedulesSubscription;
  late StreamSubscription<void> _cancelModalViewSubscription;

  late BehaviorSubject<EBSubPath> _realTimeInfoSubject;

  HomeBloc({
    required LoadingDelegate loadingDelegate,
    required HomeDelegate homeDelegate,
    required HomeRepositoryAB homeRepository,
    required ScheduleEvent scheduleEvent,
    required TokenEvent tokenEvent,
    required void Function() cancelModalViewAction,
    HomeState? homeState,
  })  : _loadingDelegate = loadingDelegate,
        _homeRepository = homeRepository,
        _scheduleEvent = scheduleEvent,
        _tokenEvent = tokenEvent,
        _cancelModalViewAction = cancelModalViewAction,
        super(homeState ?? HomeState()) {
    on<SetHomeStatus>(_onSetHomeStatus);
    on<OnAppearHomeView>(_onOnAppearHomeView);
    on<DeleteScheduleCard>(_onDeleteScheduleCard);
    on<SetCalendarState>(_onSetCalendarState);
    on<PressReloadButton>(
      _onPressReloadButton,
      transformer: _throttle(),
    );
    on<SelectTransport>(_onSelectTransport);

    _loginStatusSubscription = homeDelegate.loginStatus.listen(
      (status) => add(SetHomeStatus(login: status)),
    );

    _registerStatusSubscription = homeDelegate.registerStatus.listen(
      (status) => add(SetHomeStatus(register: status)),
    );

    _getAllSchedulesSubscription = homeDelegate.getAllSchedules.listen(
      (_) => add(OnAppearHomeView()),
    );

    _cancelModalViewSubscription = homeDelegate.cancelModalView.listen(
      (_) => _cancelModalViewAction(),
    );
  }

  @override
  Future<void> close() async {
    await _loginStatusSubscription.cancel();
    await _registerStatusSubscription.cancel();
    await _getAllSchedulesSubscription.cancel();
    await _cancelModalViewSubscription.cancel();

    await super.close();
  }
}

extension on HomeBloc {
  void _onSetHomeStatus(
    SetHomeStatus event,
    Emitter<HomeState> emit,
  ) {
    final homeStatus = state.status.copyWith(
      login: event.login,
      register: event.register,
      getAllScheduleCard: event.getAllScheduleCard,
      deleteScheduleCard: event.deleteScheduleCard,
    );

    emit(state.copyWith(status: homeStatus));
  }
}

extension on HomeBloc {
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

extension on HomeBloc {
  EBSubPath? getCloseTransportSubPath(List<EBSubPath> subPathList) {
    for (var subPath in subPathList) {
      if (subPath.type != 3) {
        return subPath;
      }
    }
    return null;
  }

  Transport? getSelectedTransport(EBSubPath subPath) {
    final transportList = subPath.transportList;

    switch (transportList) {
      case SubwayList():
        return transportList.subwayList.firstOrNull;
      case BusList():
        return transportList.busList.firstOrNull;
      default:
        return null;
    }
  }

  InfoMiddleTransportState _makeMockMiddleState() {
    final ebPath = EBPath.mockDongToGwang();
    final transportSubPath =
        getCloseTransportSubPath(ebPath.ebSubPathList) ?? EBSubPath.mockBus();
    final streamRealTimeInfo =
        _makeStreamRealTimeInfo(subPath: transportSubPath);
    final selectedTransport = getSelectedTransport(transportSubPath);

    final middleTransportInfoState = InfoMiddleTransportState(
      selectedTransport: selectedTransport,
      trasnportSubPath: transportSubPath,
      streamRealTimeInfo: streamRealTimeInfo,
    );

    return middleTransportInfoState;
  }

  Future<SealedMiddleTransportState> initSealedMiddleTransportState({
    required DaySchedule daySchedule,
  }) async {
    // final closeSchedulePath = daySchedule.getCloseTodaySchedulePath();
    // if (closeSchedulePath == null) {
    //   return AddScheduleMiddleTransportState();
    // }

    // final ebPath = closeSchedulePath.ebPath;
    // if (ebPath == null) {
    //   return AddRouteMiddleTransportState(schedulePath: closeSchedulePath);
    // } else {
    //   // cehckckckckckck
    //   final subPath = ebPath.ebSubPaths.first;
    //   final streamRealTimeInfo = _makeStreamRealTimeInfo(subPath: subPath);

    //   return InfoMiddleTransportState(
    //     subPath: subPath,
    //     streamRealTimeInfo: streamRealTimeInfo,
    //   );
    // }

    final middleState = _makeMockMiddleState();
    return middleState;
  }

  Future<void> _onOnAppearHomeView(
    OnAppearHomeView event,
    Emitter<HomeState> emit,
  ) async {
    _loadingDelegate.set();

    getAllScheduleCardsEvent(String accessToken) async {
      return await _homeRepository.getAllSchedules(
        accessToken: accessToken,
      );
    }

    final Result getAllSchedulesResult =
        await _tokenEvent.checkExpired(withEvent: getAllScheduleCardsEvent);

    _loadingDelegate.dismiss();

    switch (getAllSchedulesResult) {
      case Success():
        final homeStatus =
            state.status.copyWith(getAllScheduleCard: BaseStatus.success);

        final List<SchedulePath> allSchedules =
            getAllSchedulesResult.success.model;
        final daySchedule = DaySchedule.init(allSchedules: allSchedules);

        final calendarState = CalendarState();

        final topScheduleInfoState = SealedTopScheduleState.init(
          daySchedule: daySchedule,
        );

        final middleTransportInfoState =
            await initSealedMiddleTransportState(daySchedule: daySchedule);

        final bottomScheduleListState = BottomScheduleListState.init(
          calendarState: calendarState,
          daySchedule: daySchedule,
        );

        emit(
          state.copyWith(
            status: homeStatus,
            daySchedule: daySchedule,
            calendarState: calendarState,
            topScheduleInfoState: topScheduleInfoState,
            middleTransportInfoState: middleTransportInfoState,
            bottomScheduleListState: bottomScheduleListState,
          ),
        );
      case Failure():
        _tokenEvent.failureAction(
          result: getAllSchedulesResult,
          withAction: () {
            final homeStatus =
                state.status.copyWith(getAllScheduleCard: BaseStatus.fail);
            emit(state.copyWith(status: homeStatus));
          },
        );
    }
  }
}

extension on HomeBloc {
  void _failActionOnDeleteScheduleCard({
    required Emitter<HomeState> emit,
  }) {
    final homeStatus =
        state.status.copyWith(deleteScheduleCard: BaseStatus.fail);
    emit(state.copyWith(status: homeStatus));
  }

  void _successActionOnDeleteScheduleCard({
    required DeleteScheduleCard event,
    required Emitter<HomeState> emit,
  }) {
    final homeStatus = state.status.copyWith(
      deleteScheduleCard: BaseStatus.success,
    );

    final daySchedule = state.daySchedule.delete(
      schedulePath: event.schedulePath,
    );

    final topScheduleInfoState = SealedTopScheduleState.init(
      daySchedule: daySchedule,
    );

    final bottomScheduleListState = BottomScheduleListState.init(
      calendarState: state.calendarState,
      daySchedule: daySchedule,
    );

    emit(
      state.copyWith(
        status: homeStatus,
        daySchedule: daySchedule,
        topScheduleInfoState: topScheduleInfoState,
        bottomScheduleListState: bottomScheduleListState,
      ),
    );
  }

  Future<void> _onDeleteScheduleCard(
    DeleteScheduleCard event,
    Emitter<HomeState> emit,
  ) async {
    final scheduleID = event.schedulePath.schedule.id;
    if (scheduleID == null) {
      _failActionOnDeleteScheduleCard(emit: emit);
      return;
    }

    await _scheduleEvent.delete(
      scheduleID: scheduleID,
      successAction: () => _successActionOnDeleteScheduleCard(
        emit: emit,
        event: event,
      ),
      failAction: () => _failActionOnDeleteScheduleCard(emit: emit),
    );
  }
}

extension on HomeBloc {
  void _onSetCalendarState(
    SetCalendarState event,
    Emitter<HomeState> emit,
  ) {
    final bottomScheduleListState = BottomScheduleListState.init(
      calendarState: event.calendarState,
      daySchedule: state.daySchedule,
    );

    emit(
      state.copyWith(
        calendarState: event.calendarState,
        bottomScheduleListState: bottomScheduleListState,
      ),
    );
  }
}

extension on HomeBloc {
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
}

extension on HomeBloc {
  Future<void> _onPressReloadButton(
    PressReloadButton event,
    Emitter<HomeState> emit,
  ) async {
    final middleState =
        castOrNull<InfoMiddleTransportState>(state.middleTransportInfoState);
    if (middleState == null) {
      return;
    }

    final subPath = middleState.trasnportSubPath;
    _realTimeInfoSubject.add(subPath);
  }

  EventTransformer<Event> _throttle<Event>({
    Duration duration = const Duration(seconds: 3),
  }) {
    return (events, mapper) => events.throttleTime(duration).switchMap(mapper);
  }
}

extension on HomeBloc {
  void _onSelectTransport(
    SelectTransport event,
    Emitter<HomeState> emit,
  ) {
    final middleState = state.middleTransportInfoState;

    if (middleState is InfoMiddleTransportState) {
      final newMiddleState = middleState.copyWith(
        selectedTransport: () => event.selectedTransport,
      );
      log("checkck");
      emit(
        state.copyWith(
          middleTransportInfoState: newMiddleState,
        ),
      );
    }
  }
}
