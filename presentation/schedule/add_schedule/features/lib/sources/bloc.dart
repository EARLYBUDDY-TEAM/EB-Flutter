part of '../eb_add_schedule_feature.dart';

final class AddScheduleBloc extends Bloc<AddScheduleEvent, AddScheduleState> {
  final LoadingDelegate _loadingDelegate;
  final ScheduleRepository _scheduleRepository;
  final TokenEvent _tokenEvent;

  final Function() _cancelModalViewAction;

  late StreamSubscription<Place> selectPlaceSubscriptionForEnd;
  late StreamSubscription<PathInfo> selectPlaceSubscriptionForStart;
  late StreamSubscription<void> cancelModalViewSubscription;

  AddScheduleBloc({
    required LoadingDelegate loadingDelegate,
    required AddScheduleDelegate addScheduleDelegate,
    required ScheduleRepository scheduleRepository,
    required TokenEvent tokenEvent,
    required void Function() cancelModalViewAction,
    AddScheduleState? addScheduleState,
  })  : _loadingDelegate = loadingDelegate,
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
    on<PressAlertOkButton>(_onPressAlertOkButton);
    on<SetAddScheduleResult>(_onSetAddScheduleResult);

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
  void _onChangeTitle(
    ChangeTitle event,
    Emitter<AddScheduleState> emit,
  ) {
    final title = event.title.trim();
    final newInfo = state.info.copyWith(title: title);
    final newStatus =
        title.isEmpty ? FormStatus.inComplete : FormStatus.complete;
    emit(state.copyWith(
      info: newInfo,
      status: newStatus,
    ));
  }
}

extension on AddScheduleBloc {
  void _onChangeMemo(
    ChangeMemo event,
    Emitter<AddScheduleState> emit,
  ) {
    final memo = event.memo.trim();
    final newInfo = state.info.copyWith(memo: memo);
    emit(state.copyWith(info: newInfo));
  }
}

extension on AddScheduleBloc {
  void _onChangeTime(
    ChangeTime event,
    Emitter<AddScheduleState> emit,
  ) {
    final newInfo = state.info.copyWith(time: event.time);
    emit(state.copyWith(info: newInfo));
  }
}

extension on AddScheduleBloc {
  void _onChangeScheduleNotify(
    ChangeNotifySchedule event,
    Emitter<AddScheduleState> emit,
  ) {
    final isNotify =
        (event.notifyScheduleState is TrueNotifyScheduleState) ? true : false;
    final newInfo = state.info.copyWith(isNotify: isNotify);
    emit(
      state.copyWith(
        info: newInfo,
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
    emit(
      state.copyWith(
        notifyTransportState: event.notifyTransportState,
      ),
    );
  }
}

extension on AddScheduleBloc {
  void _onPressAddScheduleButton(
    PressAddScheduleButton event,
    Emitter<AddScheduleState> emit,
  ) async {
    _loadingDelegate.set();

    addScheduleEvent(String accessToken) async {
      return await _scheduleRepository.addSchedule(
        accessToken: accessToken,
        scheduleInfo: state.info,
      );
    }

    final Result addScheduleResult =
        await _tokenEvent.checkExpired(withEvent: addScheduleEvent);

    _loadingDelegate.dismiss();

    switch (addScheduleResult) {
      case Success():
        emit(state.copyWith(result: BaseStatus.success));
      case Failure():
        if (addScheduleResult.failure is FailureResponse) {
          if (addScheduleResult.failure.statusCode != 490) {
            emit(state.copyWith(result: BaseStatus.fail));
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
    final schedule = state.info.copyWith(endPlace: () => event.place);
    emit(state.copyWith(info: schedule));
  }
}

extension on AddScheduleBloc {
  void _onSelectStartPlace(
    SelectStartPlace event,
    Emitter<AddScheduleState> emit,
  ) {
    final startPlace = event.pathInfo.startPlace;
    final endPlace = event.pathInfo.endPlace;
    final schedule = state.info.copyWith(
      startPlace: () => startPlace,
      endPlace: () => endPlace,
    );
    final startPlaceState = SelectedStartPlaceState(pathInfo: event.pathInfo);
    emit(state.copyWith(info: schedule, startPlaceState: startPlaceState));
  }
}

extension on AddScheduleBloc {
  void _onRemoveStartPlace(
    RemoveStartPlace event,
    Emitter<AddScheduleState> emit,
  ) {
    final schedule = state.info.copyWith(startPlace: () => null);
    final startPlaceState = EmptyStartPlaceState();

    emit(
      state.copyWith(
        info: schedule,
        startPlaceState: startPlaceState,
      ),
    );
  }
}

extension on AddScheduleBloc {
  void _onPressAlertOkButton(
    PressAlertOkButton event,
    Emitter<AddScheduleState> emit,
  ) {
    add(const SetAddScheduleResult(result: BaseStatus.init));
  }
}

extension on AddScheduleBloc {
  void _onSetAddScheduleResult(
    SetAddScheduleResult event,
    Emitter<AddScheduleState> emit,
  ) {
    emit(state.copyWith(result: event.result));
  }
}
