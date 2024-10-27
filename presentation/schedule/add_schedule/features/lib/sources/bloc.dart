part of '../eb_add_schedule_feature.dart';

final class AddScheduleBloc extends Bloc<AddScheduleEvent, AddScheduleState> {
  final LoadingDelegate _loadingDelegate;
  final HomeDelegate _homeDelegate;

  final ScheduleRepository _scheduleRepository;
  final TokenEvent _tokenEvent;

  final Function() _cancelModalViewAction;

  late StreamSubscription<Place> selectPlaceSubscriptionForEnd;
  late StreamSubscription<PathInfo> selectPlaceSubscriptionForStart;
  late StreamSubscription<void> cancelModalViewSubscription;

  AddScheduleBloc({
    required LoadingDelegate loadingDelegate,
    required HomeDelegate homeDelegate,
    required AddScheduleDelegate addScheduleDelegate,
    required ScheduleRepository scheduleRepository,
    required TokenEvent tokenEvent,
    required void Function() cancelModalViewAction,
    AddScheduleState? addScheduleState,
  })  : _loadingDelegate = loadingDelegate,
        _homeDelegate = homeDelegate,
        _scheduleRepository = scheduleRepository,
        _tokenEvent = tokenEvent,
        _cancelModalViewAction = cancelModalViewAction,
        super(addScheduleState ?? AddScheduleState()) {
    on<ChangeTitle>(_onChangeTitle);
    on<ChangeMemo>(_onChangeMemo);
    on<ChangeTime>(_onChangeTime);
    on<ChangeDate>(_onChangeDate);
    on<ChangeNotifySchedule>(_onChangeScheduleNotify);
    on<ChangeNotifyTransport>(_onChangeNotifyTransport);
    on<SetTrueNotifyTransportState>(_onSetTrueNotifyTransportState);
    on<PressAddScheduleButton>(_onPressAddScheduleButton);
    on<SelectEndPlace>(_onSelectEndPlace);
    on<SelectStartPlace>(_onSelectStartPlace);
    on<RemoveStartPlace>(_onRemoveStartPlace);
    on<SetAddScheduleResultStatus>(_onSetAddScheduleResult);
    on<SetupAddScheduleView>(_onSetupAddScheduleView);
    on<PressDeleteButton>(_onPressDeleteButton);

    selectPlaceSubscriptionForEnd = addScheduleDelegate.selectEndPlace
        .listen((place) => add(SelectEndPlace(place: place)));
    selectPlaceSubscriptionForStart = addScheduleDelegate.selectStartPlace
        .listen((pathInfo) => add(SelectStartPlace(pathInfo: pathInfo)));

    cancelModalViewSubscription = addScheduleDelegate.cancelModalView
        .listen((_) => _cancelModalViewAction());
  }

  @override
  Future<void> close() async {
    await selectPlaceSubscriptionForEnd.cancel();
    await selectPlaceSubscriptionForStart.cancel();
    await cancelModalViewSubscription.cancel();
    await super.close();
  }
}

extension on AddScheduleBloc {
  FormStatus _checkFormStatus(Schedule schedule) {
    final title = schedule.title.trim();
    return (title.isEmpty) ? FormStatus.inComplete : FormStatus.complete;
  }
}

extension on AddScheduleBloc {
  void _onChangeTitle(
    ChangeTitle event,
    Emitter<AddScheduleState> emit,
  ) {
    final title = event.title.trim();
    final schedule = state.schedule.copyWith(title: title);
    final status = _checkFormStatus(schedule);
    emit(
      state.copyWith(
        schedule: schedule,
        status: status,
      ),
    );
  }
}

extension on AddScheduleBloc {
  void _onChangeMemo(
    ChangeMemo event,
    Emitter<AddScheduleState> emit,
  ) {
    final memo = event.memo.trim();
    final schedule = state.schedule.copyWith(memo: () => memo);
    final status = _checkFormStatus(schedule);
    emit(
      state.copyWith(
        schedule: schedule,
        status: status,
      ),
    );
  }
}

extension on AddScheduleBloc {
  void _onChangeTime(
    ChangeTime event,
    Emitter<AddScheduleState> emit,
  ) {
    final timeOfDay = event.time;
    final time = state.schedule.time.copyWith(
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
    );

    final schedule = state.schedule.copyWith(time: time);
    final status = _checkFormStatus(schedule);
    emit(
      state.copyWith(
        schedule: schedule,
        status: status,
      ),
    );
  }

  void _onChangeDate(
    ChangeDate event,
    Emitter<AddScheduleState> emit,
  ) {
    final date = event.date;
    final time = state.schedule.time.copyWith(
      year: date.year,
      month: date.month,
      day: date.day,
    );

    final schedule = state.schedule.copyWith(time: time);
    final status = _checkFormStatus(schedule);
    emit(
      state.copyWith(
        schedule: schedule,
        status: status,
      ),
    );
  }
}

extension on AddScheduleBloc {
  void _onChangeScheduleNotify(
    ChangeNotifySchedule event,
    Emitter<AddScheduleState> emit,
  ) {
    final notifyScheduleState = event.notifyScheduleState;
    final notifySchedule = (notifyScheduleState is TrueNotifyScheduleState)
        ? notifyScheduleState.beforeNotifyMinute
        : null;
    final schedule =
        state.schedule.copyWith(notifySchedule: () => notifySchedule);
    final status = _checkFormStatus(schedule);
    emit(
      state.copyWith(
        status: status,
        schedule: schedule,
        notifyScheduleState: event.notifyScheduleState,
      ),
    );
  }
}

extension on AddScheduleBloc {
  void _onChangeNotifyTransport(
    ChangeNotifyTransport event,
    Emitter<AddScheduleState> emit,
  ) {
    final notifyTransportState = event.notifyTransportState;
    final notifyTransport = (notifyTransportState is TrueNotifyTransportState)
        ? notifyTransportState.beforeNotifyMinute
        : null;
    final notifyTransportRange =
        (notifyTransportState is TrueNotifyTransportState)
            ? notifyTransportState.beforeNotifyMinuteRange
            : null;
    final schedule = state.schedule.copyWith(
      notifyTransport: () => notifyTransport,
      notifyTransportRange: () => notifyTransportRange,
    );
    final status = _checkFormStatus(schedule);
    emit(
      state.copyWith(
        status: status,
        schedule: schedule,
        notifyTransportState: notifyTransportState,
      ),
    );
  }
}

extension on AddScheduleBloc {
  void _onSetTrueNotifyTransportState(
    SetTrueNotifyTransportState event,
    Emitter<AddScheduleState> emit,
  ) {
    final notifyTransportState = state.notifyTransportState;
    if (notifyTransportState is! TrueNotifyTransportState) {
      return;
    }

    final trueNotifyTransportState = notifyTransportState.copyWith(
      beforeNotifyMinute: event.beforeNotifyMinute,
      beforeNotifyMinuteRange: event.beforeNotifyMinuteRange,
    );

    final schedule = state.schedule.copyWith(
      notifyTransport: () => trueNotifyTransportState.beforeNotifyMinute,
      notifyTransportRange: () =>
          trueNotifyTransportState.beforeNotifyMinuteRange,
    );

    final status = _checkFormStatus(schedule);

    emit(
      state.copyWith(
        notifyTransportState: trueNotifyTransportState,
        schedule: schedule,
        status: status,
      ),
    );
  }
}

extension on AddScheduleBloc {
  void _onPressAddScheduleButton(
    PressAddScheduleButton event,
    Emitter<AddScheduleState> emit,
  ) async {
    switch (state.setting) {
      case (InitAddScheduleSetting()):
        await _requestCreateSchedule(emit);
      case (ChangeAddScheduleSetting()):
        await _requestUpdateSchedule(emit);
    }
    _homeDelegate.getAllSchedules.add(());
  }

  Future<void> _requestCreateSchedule(
    Emitter<AddScheduleState> emit,
  ) async {
    _loadingDelegate.set();

    final schedule = state.schedule;
    final startPlaceState = state.startPlaceState;
    final ebPath = (startPlaceState is SelectedStartPlaceState)
        ? startPlaceState.pathInfo.ebPath
        : null;

    log(schedule.notifyTransportRange.toString());

    Future<Result> addScheduleEvent(String accessToken) async {
      return await _scheduleRepository.create(
        accessToken: accessToken,
        schedule: schedule,
        ebPath: ebPath,
      );
    }

    final Result addScheduleResult =
        await _tokenEvent.checkExpired(withEvent: addScheduleEvent);

    _loadingDelegate.dismiss();

    switch (addScheduleResult) {
      case Success():
        add(
          SetAddScheduleResultStatus(
            result: CreateAddScheduleResult(status: BaseStatus.success),
          ),
        );
      case Failure():
        if (addScheduleResult.failure is FailureResponse) {
          if (addScheduleResult.failure.statusCode != 490) {
            add(
              SetAddScheduleResultStatus(
                result: CreateAddScheduleResult(status: BaseStatus.fail),
              ),
            );
          }
        }
    }
  }

  Future<void> _requestUpdateSchedule(
    Emitter<AddScheduleState> emit,
  ) async {
    _loadingDelegate.set();

    final schedule = state.schedule;
    final startPlaceState = state.startPlaceState;
    final ebPath = (startPlaceState is SelectedStartPlaceState)
        ? startPlaceState.pathInfo.ebPath
        : null;

    Future<Result> addScheduleEvent(String accessToken) async {
      return await _scheduleRepository.update(
        accessToken: accessToken,
        schedule: schedule,
        ebPath: ebPath,
      );
    }

    final Result addScheduleResult =
        await _tokenEvent.checkExpired(withEvent: addScheduleEvent);

    _loadingDelegate.dismiss();

    switch (addScheduleResult) {
      case Success():
        add(
          SetAddScheduleResultStatus(
            result: UpdateAddScheduleResult(status: BaseStatus.success),
          ),
        );
      case Failure():
        if (addScheduleResult.failure is FailureResponse) {
          if (addScheduleResult.failure.statusCode != 490) {
            add(
              SetAddScheduleResultStatus(
                result: UpdateAddScheduleResult(status: BaseStatus.fail),
              ),
            );
          }
        }
    }
  }
}

extension on AddScheduleBloc {
  void _onSelectEndPlace(
    SelectEndPlace event,
    Emitter<AddScheduleState> emit,
  ) {
    final schedule = state.schedule.copyWith(endPlace: () => event.place);
    final status = _checkFormStatus(state.schedule);
    emit(state.copyWith(
      schedule: schedule,
      status: status,
    ));
  }
}

extension on AddScheduleBloc {
  void _onSelectStartPlace(
    SelectStartPlace event,
    Emitter<AddScheduleState> emit,
  ) {
    final startPlace = event.pathInfo.startPlace;
    final endPlace = event.pathInfo.endPlace;
    final schedule = state.schedule.copyWith(
      startPlace: () => startPlace,
      endPlace: () => endPlace,
    );
    final startPlaceState = SelectedStartPlaceState(pathInfo: event.pathInfo);
    final status = _checkFormStatus(state.schedule);
    emit(
      state.copyWith(
        schedule: schedule,
        startPlaceState: startPlaceState,
        status: status,
      ),
    );
  }
}

extension on AddScheduleBloc {
  void _onRemoveStartPlace(
    RemoveStartPlace event,
    Emitter<AddScheduleState> emit,
  ) {
    final schedule = state.schedule.copyWith(startPlace: () => null);
    final startPlaceState = EmptyStartPlaceState();

    emit(
      state.copyWith(
        schedule: schedule,
        startPlaceState: startPlaceState,
      ),
    );
  }
}

extension on AddScheduleBloc {
  void _onSetAddScheduleResult(
    SetAddScheduleResultStatus event,
    Emitter<AddScheduleState> emit,
  ) {
    emit(state.copyWith(result: event.result));
  }
}

extension on AddScheduleBloc {
  void _onSetupAddScheduleView(
    SetupAddScheduleView event,
    Emitter<AddScheduleState> emit,
  ) {
    final setting = event.setting;
    switch (setting) {
      case InitAddScheduleSetting():
        emit(state.copyWith(setting: setting));
      case ChangeAddScheduleSetting():
        emit(
          state.copyWith(
            setting: setting,
            schedule: setting.schedule,
            status: FormStatus.inComplete,
            startPlaceState: _getStartPlaceState(
              schedule: setting.schedule,
              ebPath: setting.ebPath,
            ),
            notifyScheduleState:
                _getNotifyScheduleState(schedule: setting.schedule),
            notifyTransportState:
                _getNotifyTransportState(schedule: setting.schedule),
          ),
        );
    }
  }

  SealedNotifyTransportState _getNotifyTransportState({
    required Schedule schedule,
  }) {
    final notifyTransport = schedule.notifyTransport;
    final notifyTransportRange = schedule.notifyTransportRange;

    return ((notifyTransport != null) && (notifyTransportRange != null))
        ? TrueNotifyTransportState(
            beforeNotifyMinute: notifyTransport,
            beforeNotifyMinuteRange: notifyTransportRange)
        : FalseNotifyTransportState();
  }

  SealedNotifyScheduleState _getNotifyScheduleState({
    required Schedule schedule,
  }) {
    final notifySchedule = schedule.notifySchedule;
    return (notifySchedule != null)
        ? TrueNotifyScheduleState(beforeNotifyMinute: notifySchedule)
        : FalseNotifyScheduleState();
  }

  SealedStartPlaceState _getStartPlaceState({
    required Schedule schedule,
    required EBPath? ebPath,
  }) {
    if (ebPath == null) {
      return EmptyStartPlaceState();
    }

    final transportLineOfPath =
        getTransportLineOfPath(ebSubPaths: ebPath.ebSubPaths);

    final pathInfo = PathInfo(
      startPlace: schedule.startPlace!,
      endPlace: schedule.endPlace!,
      transportLineOfPath: transportLineOfPath,
      ebPath: ebPath,
    );

    return SelectedStartPlaceState(
      pathInfo: pathInfo,
    );
  }
}

extension on AddScheduleBloc {
  void _onPressDeleteButton(
    PressDeleteButton event,
    Emitter<AddScheduleState> emit,
  ) async {
    final scheduleID = state.schedule.id;
    if (scheduleID == null) {
      add(
        SetAddScheduleResultStatus(
          result: DeleteAddScheduleResult(status: BaseStatus.fail),
        ),
      );
      return;
    }

    _loadingDelegate.set();

    Future<Result> deleteScheduleEvent(String accessToken) async {
      return _scheduleRepository.delete(
        accessToken: accessToken,
        scheduleID: scheduleID,
      );
    }

    final Result deleteScheduleResult =
        await _tokenEvent.checkExpired(withEvent: deleteScheduleEvent);

    _loadingDelegate.dismiss();

    switch (deleteScheduleResult) {
      case Success():
        add(
          SetAddScheduleResultStatus(
            result: DeleteAddScheduleResult(status: BaseStatus.success),
          ),
        );
      case Failure():
        if (deleteScheduleResult.failure is FailureResponse) {
          if (deleteScheduleResult.failure.statusCode != 490) {
            add(
              SetAddScheduleResultStatus(
                result: DeleteAddScheduleResult(status: BaseStatus.fail),
              ),
            );
          }
        }
    }

    _homeDelegate.getAllSchedules.add(());
  }
}
