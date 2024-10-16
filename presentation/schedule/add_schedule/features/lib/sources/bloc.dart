part of '../eb_add_schedule_feature.dart';

final class AddScheduleBloc extends Bloc<AddScheduleEvent, AddScheduleState> {
  final LoadingDelegate _loadingDelegate;
  final ScheduleRepository _scheduleRepository;
  final TokenEvent _tokenEvent;

  final Function() _cancelEndSearchPlaceViewAction;
  final Function() _cancelStartSearchPlaceViewAction;
  final Function() _cancelFindRouteViewAction;

  late StreamSubscription<Place> selectPlaceSubscriptionForEnd;
  late StreamSubscription<Place> selectPlaceSubscriptionForStart;
  late StreamSubscription<void> cancelEndViewSubscription;
  late StreamSubscription<void> cancelStartViewSubscription;
  late StreamSubscription<void> cancelFindRouteViewSubscription;

  AddScheduleBloc({
    required LoadingDelegate loadingDelegate,
    required AddScheduleDelegate addScheduleDelegate,
    required ScheduleRepository scheduleRepository,
    required TokenEvent tokenEvent,
    required void Function() cancelEndSearchPlaceViewAction,
    required void Function() cancelStartSearchPlaceViewAction,
    required void Function() cancelFindRouteViewAction,
    AddScheduleState? addScheduleState,
  })  : _loadingDelegate = loadingDelegate,
        _scheduleRepository = scheduleRepository,
        _tokenEvent = tokenEvent,
        _cancelEndSearchPlaceViewAction = cancelEndSearchPlaceViewAction,
        _cancelStartSearchPlaceViewAction = cancelStartSearchPlaceViewAction,
        _cancelFindRouteViewAction = cancelFindRouteViewAction,
        super(addScheduleState ?? AddScheduleState()) {
    on<ChangeTitle>(_onChangeTitle);
    on<ChangeMemo>(_onChangeMemo);
    on<ChangeTime>(_onChangeTime);
    on<ChangeNotify>(_onChangeNotify);
    on<PressAddScheduleButton>(_onPressAddScheduleButton);
    on<SelectEndPlace>(_onSelectEndPlace);
    on<SelectStartPlace>(_onSelectStartPlace);
    on<RemoveRoute>(_onRemoveRoute);
    on<PressAlertOkButton>(_onPressAlertOkButton);

    selectPlaceSubscriptionForEnd = addScheduleDelegate.selectEndPlace
        .listen((place) => add(SelectEndPlace(place: place)));
    selectPlaceSubscriptionForStart = addScheduleDelegate.selectStartPlace
        .listen((place) => add(SelectStartPlace(place: place)));

    cancelEndViewSubscription = addScheduleDelegate.cancelEndSearchPlaceView
        .listen((_) => _cancelEndSearchPlaceViewAction());
    cancelStartViewSubscription = addScheduleDelegate.cancelStartSearchPlaceView
        .listen((_) => _cancelStartSearchPlaceViewAction());
    cancelFindRouteViewSubscription = addScheduleDelegate.cancelFindRouteView
        .listen((_) => _cancelFindRouteViewAction());

    on<SetAddScheduleResult>(_onSetAddScheduleResult);
  }

  @override
  Future<void> close() async {
    await selectPlaceSubscriptionForEnd.cancel();
    await selectPlaceSubscriptionForStart.cancel();
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
    final newStatus = title.isEmpty
        ? ScheduleInfoStatus.incomplete
        : ScheduleInfoStatus.complete;
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
  void _onChangeNotify(
    ChangeNotify event,
    Emitter<AddScheduleState> emit,
  ) {
    final newInfo = state.info.copyWith(isNotify: event.isNotify);
    emit(state.copyWith(info: newInfo));
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
    final Schedule info = state.info.copyWith(endPlace: event.place);
    emit(state.copyWith(info: info));
  }
}

extension on AddScheduleBloc {
  void _onSelectStartPlace(
    SelectStartPlace event,
    Emitter<AddScheduleState> emit,
  ) {
    final Schedule info = state.info.copyWith(startPlace: event.place);
    emit(state.copyWith(info: info));
  }
}

extension on AddScheduleBloc {
  void _onRemoveRoute(
    RemoveRoute event,
    Emitter<AddScheduleState> emit,
  ) {
    var info = state.info;
    info.startPlace = null;
    emit(state.copyWith(info: info));
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
