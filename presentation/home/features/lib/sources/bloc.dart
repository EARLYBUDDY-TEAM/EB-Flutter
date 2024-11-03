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

  late PublishSubject<EBSubPath> _realTimeInfoSubject;

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
    on<PressReloadButton>(_onPressReloadButton);

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
  Future<RealTimeInfo?> whenFinishLoading(
    Stream<RealTimeInfo> streamSource,
  ) async {
    await for (var realTimeInfo in streamSource) {
      return realTimeInfo;
    }
    return null;
    // await for (value in source) {
    //   // Define a condition expecting a value from Stream
    //   if (value) {
    //     return value;
    //   }
    // }
    // return false;
  }

  Stream<RealTimeInfo?> _makeStreamRealTimeInfo({
    required EBSubPath subPath,
  }) {
    _realTimeInfoSubject = PublishSubject<EBSubPath>();

    final streamRealtimeInfo = _realTimeInfoSubject.flatMap(
      (subPath) async* {
        final fetchedRealTimeInfo = await getRealTimeInfo(subPath: subPath);
        yield fetchedRealTimeInfo;
      },
    );

    var stream = Stream.periodic(const Duration(seconds: 8));
    stream.listen((_) {
      _realTimeInfoSubject.add(subPath);
    });

    return streamRealtimeInfo;
  }
}

extension on HomeBloc {
  Future<SealedMiddleTransportState> initSealedMiddleTransportState({
    required DaySchedule daySchedule,
  }) async {
    // final closeSchedulePath = daySchedule.getCloseTodaySchedulePath();
    // if (closeSchedulePath == null) {
    //   return AddScheduleMiddleTransportState();
    // }

    // if (closeSchedulePath.ebPath == null) {
    //   return AddRouteMiddleTransportState(schedulePath: closeSchedulePath);
    // } else {
    //   // cehckckckckckck
    //   final subPath = closeSchedulePath.ebPath!.ebSubPaths.first;
    //   final realTimeInfo = await getRealTimeInfo(subPath: subPath);

    //   return InfoMiddleTransportState(
    //     subPath: subPath,
    //     realTimeInfo: realTimeInfo,
    //   );
    // }

    final mockBus = EBSubPath.mockBus();
    final mockSubway = EBSubPath.mockSubway();
    final mockRealTimeInfo = RealTimeInfo.mock();
    final streamRealTimeInfo = _makeStreamRealTimeInfo(subPath: mockSubway);
    final middleTransportInfoState = InfoMiddleTransportState(
      subPath: mockSubway,
      streamRealTimeInfo: streamRealTimeInfo,
    );

    return middleTransportInfoState;
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

    final subPath = middleState.subPath;
    _realTimeInfoSubject.add(subPath);
  }
}
