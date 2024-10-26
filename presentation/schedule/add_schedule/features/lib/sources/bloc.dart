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
    on<ChangeNotifySchedule>(_onChangeScheduleNotify);
    on<ChangeNotifyTransport>(_onChangeNotifyTransport);
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
    final schedule = state.schedule.copyWith(time: event.time);
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
    final isNotify =
        (event.notifyScheduleState is TrueNotifyScheduleState) ? true : false;
    final schedule = state.schedule.copyWith(isNotify: isNotify);
    final status = _checkFormStatus(schedule);
    emit(
      state.copyWith(
        schedule: schedule,
        notifyScheduleState: event.notifyScheduleState,
        status: status,
      ),
    );
  }
}

extension on AddScheduleBloc {
  void _onChangeNotifyTransport(
    ChangeNotifyTransport event,
    Emitter<AddScheduleState> emit,
  ) {
    final status = _checkFormStatus(state.schedule);
    emit(
      state.copyWith(
        notifyTransportState: event.notifyTransportState,
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
    emit(state.copyWith(schedule: schedule));
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
    emit(state.copyWith(schedule: schedule, startPlaceState: startPlaceState));
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
          ),
        );
    }
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
