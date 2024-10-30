part of '../eb_home_feature.dart';

final class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadingDelegate _loadingDelegate;
  final HomeRepositoryAB _homeRepository;
  final TokenEvent _tokenEvent;

  final Function() _cancelModalViewAction;

  late StreamSubscription<BaseStatus> _loginStatusSubscription;
  late StreamSubscription<BaseStatus> _registerStatusSubscription;
  late StreamSubscription<void> _getAllSchedulesSubscription;
  late StreamSubscription<void> _cancelModalViewSubscription;

  HomeBloc({
    required LoadingDelegate loadingDelegate,
    required HomeDelegate homeDelegate,
    required HomeRepositoryAB homeRepository,
    required TokenEvent tokenEvent,
    required void Function() cancelModalViewAction,
  })  : _loadingDelegate = loadingDelegate,
        _homeRepository = homeRepository,
        _tokenEvent = tokenEvent,
        _cancelModalViewAction = cancelModalViewAction,
        super(HomeState()) {
    on<SetHomeStatus>(_onSetHomeStatus);
    on<OnAppearHomeView>(_onOnAppearHomeView);
    on<DeleteScheduleCard>(_onDeleteScheduleCard);
    on<SetCalendarState>(_onSetCalendarState);

    _loginStatusSubscription = homeDelegate.loginStatus.listen(
      (status) => add(SetHomeStatus(login: status)),
    );

    _registerStatusSubscription = homeDelegate.registerStatus.listen(
      (status) => add(SetHomeStatus(register: status)),
    );

    _getAllSchedulesSubscription = homeDelegate.getAllSchedules.listen(
      (_) => add(const OnAppearHomeView()),
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

        final middleTransportInfoState = SealedMiddleTransportState.init(
          daySchedule: daySchedule,
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
    if (event.schedulePath.schedule.id == null) {
      _failActionOnDeleteScheduleCard(emit: emit);
      return;
    }

    _loadingDelegate.set();

    Future<Result> deleteScheduleCardEvent(String accessToken) async {
      return await _homeRepository.deleteScheduleCard(
        accessToken: accessToken,
        scheduleID: event.schedulePath.schedule.id!,
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
      case Failure():
        _tokenEvent.failureAction(
          result: deleteScheduleCardResult,
          withAction: () => _failActionOnDeleteScheduleCard(emit: emit),
        );
    }
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
