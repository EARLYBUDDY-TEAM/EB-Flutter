part of '../eb_add_schedule_feature.dart';

final class AddScheduleBloc extends Bloc<AddScheduleEvent, AddScheduleState> {
  final LoadingDelegate _loadingDelegate;
  final ScheduleRepository _scheduleRepository;
  final TokenEvent _tokenEvent;

  final Function() _cancelModalViewAction;

  late StreamSubscription<Place> selectPlaceSubscriptionForEnd;
  late StreamSubscription<Place> selectPlaceSubscriptionForStart;
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
    on<ChangeNotify>(_onChangeNotify);
    on<PressAddScheduleButton>(_onPressAddScheduleButton);
    on<SelectEndPlace>(_onSelectEndPlace);
    on<SelectStartPlace>(_onSelectStartPlace);
    on<RemoveStartPlace>(_onRemoveStartPlace);
    on<PressAlertOkButton>(_onPressAlertOkButton);
    on<SetAddScheduleResult>(_onSetAddScheduleResult);

    selectPlaceSubscriptionForEnd = addScheduleDelegate.selectEndPlace
        .listen((place) => add(SelectEndPlace(place: place)));
    selectPlaceSubscriptionForStart = addScheduleDelegate.selectStartPlace
        .listen((place) => add(SelectStartPlace(place: place)));

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
  void _onRemoveStartPlace(
    RemoveStartPlace event,
    Emitter<AddScheduleState> emit,
  ) {
    var info = state.info;
    info.startPlace = null;
    emit(state.copyWith(info: info));

    // 수정ㅈ수젓ㅈ수ㅜ정
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
