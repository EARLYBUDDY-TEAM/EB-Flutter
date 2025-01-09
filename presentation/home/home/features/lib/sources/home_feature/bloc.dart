part of '../../home_feature.dart';

final class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeDelegate _homeDelegate;
  final LoadingDelegate _loadingDelegate;
  final HomeRepositoryAB _homeRepository;
  final EBTokenEvent _tokenEvent;
  final ScheduleEvent _scheduleEvent;

  final Function() _cancelModalViewAction;

  late StreamSubscription<BaseStatus> _loginStatusSubscription;
  late StreamSubscription<String?> _registerStatusSubscription;
  late StreamSubscription<void> _getAllSchedulesSubscription;
  late StreamSubscription<void> _cancelModalViewSubscription;

  final HomeScheduler _homeScheduler;

  HomeBloc({
    required LoadingDelegate loadingDelegate,
    required HomeDelegate homeDelegate,
    required HomeRepositoryAB homeRepository,
    required ScheduleEvent scheduleEvent,
    required EBTokenEvent tokenEvent,
    required void Function() cancelModalViewAction,
    HomeScheduler? homeScheduler,
    HomeState? homeState,
  })  : _homeDelegate = homeDelegate,
        _loadingDelegate = loadingDelegate,
        _homeRepository = homeRepository,
        _scheduleEvent = scheduleEvent,
        _tokenEvent = tokenEvent,
        _cancelModalViewAction = cancelModalViewAction,
        _homeScheduler = homeScheduler ?? HomeScheduler(),
        super(homeState ?? HomeState()) {
    on<SetHomeStatus>(_onSetHomeStatus);
    on<OnAppearHomeView>(_onOnAppearHomeView);
    on<DeleteScheduleCard>(_onDeleteScheduleCard);
    on<SetCalendarState>(_onSetCalendarState);
    on<PressRegisterConfirmButton>(_onPressRegisterConfirmButton);
    on<HomeSchedulerAction>(_onHomeSchedulerAction);

    _loginStatusSubscription = homeDelegate.loginStatus.listen(
      (status) => add(SetHomeStatus(login: status)),
    );

    _registerStatusSubscription = homeDelegate.registerStatus.listen(
      (nickName) => add(SetHomeStatus(register: () => nickName)),
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
    final loginStatus = event.login ?? BaseStatus.init;
    final login = loginStatus == BaseStatus.success
        ? !state.status.login
        : state.status.login;

    final homeStatus = state.status.copyWith(
      login: login,
      register: event.register,
      getAllScheduleCard: event.getAllScheduleCard,
      deleteScheduleCard: event.deleteScheduleCard,
    );

    emit(state.copyWith(status: homeStatus));
  }
}

extension on HomeBloc {
  Future<void> _onOnAppearHomeView(
    OnAppearHomeView event,
    Emitter<HomeState> emit,
  ) async {
    await _homeScheduler.tearDown();

    _loadingDelegate.set();

    Future<NetworkResponse<List<SchedulePath>>> getAllScheduleCardsEvent(
        String accessToken) async {
      return await _homeRepository.getAllSchedules(
        accessToken: accessToken,
      );
    }

    final NetworkResponse<List<SchedulePath>> getAllSchedulesResult =
        await _tokenEvent.checkExpired(withEvent: getAllScheduleCardsEvent);

    _loadingDelegate.dismiss();

    switch (getAllSchedulesResult) {
      case SuccessResponse():
        final homeStatus =
            state.status.copyWith(getAllScheduleCard: BaseStatus.success);

        final List<SchedulePath> allSchedules = getAllSchedulesResult.model;
        final daySchedule = DaySchedule.init(allSchedules: allSchedules);

        final calendarState = CalendarState();

        final topScheduleInfoState = SealedTopScheduleState.init(
          daySchedule: daySchedule,
        );

        final todayCloseSchedulePath = daySchedule.closeTodaySchedulePath;
        final middleTransportInfoState = MiddleTransportInfoState(
          todayCloseSchedulePath: todayCloseSchedulePath,
        );

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

        _homeScheduler.start(
          action: () {
            add(HomeSchedulerAction());
          },
        );
      case FailureResponse():
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

    final todayCloseSchedulePath = daySchedule.closeTodaySchedulePath;
    final middleTransportInfoState = MiddleTransportInfoState(
      todayCloseSchedulePath: todayCloseSchedulePath,
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
        middleTransportInfoState: middleTransportInfoState,
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
  void _onPressRegisterConfirmButton(
    PressRegisterConfirmButton event,
    Emitter<HomeState> emit,
  ) {
    _homeDelegate.registerStatus.add(null);
    emit(
      state.copyWith(
        status: state.status.copyWith(register: () => null),
      ),
    );
  }
}

extension on HomeBloc {
  void _onHomeSchedulerAction(
    HomeSchedulerAction event,
    Emitter<HomeState> emit,
  ) {
    final now = DateTime.now();
    log('schedulerAction, now: $now');

    final tmpDaySchedule = state.daySchedule;

    final closeTodaySchedulePath =
        DaySchedule.getCloseTodaySchedulePath(tmpDaySchedule.data);
    final daySchedule = tmpDaySchedule.copyWith(
      closeTodaySchedulePath: () => closeTodaySchedulePath,
    );

    final topScheduleInfoState = SealedTopScheduleState.init(
      daySchedule: daySchedule,
    );
    emit(state.copyWith(topScheduleInfoState: topScheduleInfoState));

    final todayCloseSchedulePath = daySchedule.closeTodaySchedulePath;
    final originTodayCloseSchedulePath =
        state.middleTransportInfoState.todayCloseSchedulePath;

    if (todayCloseSchedulePath != originTodayCloseSchedulePath) {
      final middleTransportInfoState = MiddleTransportInfoState(
        todayCloseSchedulePath: todayCloseSchedulePath,
      );

      emit(
        state.copyWith(
          middleTransportInfoState: middleTransportInfoState,
        ),
      );
    }
  }
}
