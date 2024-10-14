part of '../eb_home_feature.dart';

final class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadingDelegate _loadingDelegate;
  final HomeRepositoryAB _homeRepository;
  final TokenEvent _tokenEvent;

  late StreamSubscription<BaseStatus> _loginStatusSubscription;
  late StreamSubscription<BaseStatus> _registerStatusSubscription;

  HomeBloc({
    required LoadingDelegate loadingDelegate,
    required HomeDelegate homeDelegate,
    required HomeRepositoryAB homeRepository,
    required TokenEvent tokenEvent,
  })  : _loadingDelegate = loadingDelegate,
        _homeRepository = homeRepository,
        _tokenEvent = tokenEvent,
        super(HomeState()) {
    on<SetHomeStatus>(_onSetHomeStatus);
    on<OnAppearHomeView>(_onOnAppearHomeView);
    on<DeleteScheduleCard>(_onDeleteScheduleCard);
    on<TapCalendarDay>(_onTapCalendarDay);

    _loginStatusSubscription = homeDelegate.loginStatus.listen(
      (status) => add(SetHomeStatus(login: status)),
    );

    _registerStatusSubscription = homeDelegate.registerStatus.listen(
      (status) => add(SetHomeStatus(register: status)),
    );
  }

  @override
  Future<void> close() {
    _loginStatusSubscription.cancel();
    _registerStatusSubscription.cancel();
    return super.close();
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

        final List<Schedule> allSchedules = getAllSchedulesResult.success.model;
        final daySchedule = DaySchedule.initWithAllSchedules(
          allSchedules: allSchedules,
        );

        final calendarState = CalendarState(
          selectedDay: DateTime.now(),
        );

        final List<Schedule> selectedSchedules = daySchedule.get(
          selectedDay: calendarState.selectedDay,
        );
        final bottomScheduleListState = BottomScheduleListState(
          selectedSchedules: selectedSchedules,
        );

        emit(
          state.copyWith(
            status: homeStatus,
            daySchedule: daySchedule,
            calendarState: calendarState,
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

  Future<void> _onDeleteScheduleCard(
    DeleteScheduleCard event,
    Emitter<HomeState> emit,
  ) async {
    if (event.schedule.id == null) {
      _failActionOnDeleteScheduleCard(emit: emit);
    }

    _loadingDelegate.set();

    Future<Result> deleteScheduleCardEvent(String accessToken) async {
      return await _homeRepository.deleteScheduleCard(
        accessToken: accessToken,
        scheduleID: event.schedule.id!,
      );
    }

    final Result deleteScheduleCardResult =
        await _tokenEvent.checkExpired(withEvent: deleteScheduleCardEvent);

    _loadingDelegate.dismiss();

    switch (deleteScheduleCardResult) {
      case Success():
        final homeStatus = state.status.copyWith(
          deleteScheduleCard: BaseStatus.success,
        );

        final daySchedule = state.daySchedule.delete(
          schedule: event.schedule,
        );

        final selectedSchedules = daySchedule.get(
          selectedDay: state.calendarState.selectedDay,
        );
        final bottomScheduleListState = BottomScheduleListState(
          selectedSchedules: selectedSchedules,
        );

        emit(
          state.copyWith(
            status: homeStatus,
            daySchedule: daySchedule,
            bottomScheduleListState: bottomScheduleListState,
          ),
        );
        return;
      case Failure():
        _tokenEvent.failureAction(
          result: deleteScheduleCardResult,
          withAction: () => _failActionOnDeleteScheduleCard(emit: emit),
        );
    }
  }
}

extension on HomeBloc {
  void _onTapCalendarDay(
    TapCalendarDay event,
    Emitter<HomeState> emit,
  ) {
    final calendarState = CalendarState(
      selectedDay: event.selectedDay,
    );

    final List<Schedule> selectedSchedules = state.daySchedule.get(
      selectedDay: event.selectedDay,
    );
    final bottomScheduleListState = BottomScheduleListState(
      selectedSchedules: selectedSchedules,
    );
    emit(
      state.copyWith(
        calendarState: calendarState,
        bottomScheduleListState: bottomScheduleListState,
      ),
    );
  }
}
