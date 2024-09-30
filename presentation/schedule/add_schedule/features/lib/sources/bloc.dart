part of '../eb_add_schedule_feature.dart';

final class AddScheduleBloc extends Bloc<AddScheduleEvent, AddScheduleState> {
  final LoadingDelegate _loadingDelegate;
  late StreamSubscription<Place> selectPlaceSubscriptionForPlace;
  late StreamSubscription<Place> selectPlaceSubscriptionForRoute;
  final ScheduleRepository _scheduleRepository;
  final TokenEvent _tokenEvent;

  AddScheduleBloc({
    required LoadingDelegate loadingDelegate,
    required SearchPlaceDelegateForPlace searchPlaceDelegateForPlace,
    required SearchPlaceDelegateForRoute searchPlaceDelegateForRoute,
    required ScheduleRepository scheduleRepository,
    required TokenEvent tokenEvent,
    AddScheduleState? addScheduleState,
  })  : _loadingDelegate = loadingDelegate,
        _scheduleRepository = scheduleRepository,
        _tokenEvent = tokenEvent,
        super(addScheduleState ?? AddScheduleState()) {
    on<ChangeTitle>(_onChangeTitle);
    on<ChangeMemo>(_onChangeMemo);
    on<ChangeTime>(_onChangeTime);
    on<ChangeNotify>(_onChangeNotify);
    on<PressAddScheduleButton>(_onPressAddScheduleButton);
    on<SelectPlace>(_onSelectPlace);
    on<SelectRoute>(_onSelectRoute);
    on<RemoveRoute>(_onRemoveRoute);
    on<PressAlertOkButton>(_onPressAlertOkButton);
    selectPlaceSubscriptionForPlace = searchPlaceDelegateForPlace.selectPlace
        .listen((place) => add(SelectPlace(place: place)));
    selectPlaceSubscriptionForRoute = searchPlaceDelegateForRoute.selectPlace
        .listen((place) => add(SelectRoute(place: place)));

    on<SetAddScheduleResult>(_onSetAddScheduleResult);
  }

  @override
  Future<void> close() async {
    await selectPlaceSubscriptionForPlace.cancel();
    await selectPlaceSubscriptionForRoute.cancel();
    return super.close();
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

    final Result addScheduleResult =
        await _scheduleRepository.addSchedule(scheduleInfo: state.info);
    final Result result = await _tokenEvent.check(preResult: addScheduleResult);

    _loadingDelegate.dismiss();

    switch (result) {
      case Success():
        emit(state.copyWith(result: AddScheduleResult.success));
      case Failure():
        switch (result.failure.statusCode) {
          case (!= 490):
            emit(state.copyWith(result: AddScheduleResult.fail));
        }
    }
  }
}

extension on AddScheduleBloc {
  void _onSelectPlace(
    SelectPlace event,
    Emitter<AddScheduleState> emit,
  ) {
    final ScheduleInfo info = state.info.copyWith(endPlace: event.place);
    emit(state.copyWith(info: info));
  }
}

extension on AddScheduleBloc {
  void _onSelectRoute(
    SelectRoute event,
    Emitter<AddScheduleState> emit,
  ) {
    final ScheduleInfo info = state.info.copyWith(startPlace: event.place);
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
    add(const SetAddScheduleResult(result: AddScheduleResult.init));
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
