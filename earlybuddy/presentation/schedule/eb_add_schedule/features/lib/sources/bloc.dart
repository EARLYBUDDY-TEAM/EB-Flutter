part of '../eb_add_schedule_feature.dart';

final class AddScheduleBloc extends Bloc<AddScheduleEvent, AddScheduleState> {
  late StreamSubscription<Place> sinkPressSelectPlaceButtonForPlace;
  late StreamSubscription<Place> sinkPressSelectPlaceButtonForRoute;

  final ScheduleRepository scheduleRepository;

  AddScheduleBloc({
    required SearchPlaceDelegateForPlace searchPlaceDelegateForPlace,
    required SearchPlaceDelegateForRoute searchPlaceDelegateForRoute,
    required this.scheduleRepository,
    AddScheduleState? addScheduleState,
  }) : super(addScheduleState ?? AddScheduleState()) {
    on<ChangeTitle>(_onChangeTitle);
    on<ChangeMemo>(_onChangeMemo);
    on<ChangeTime>(_onChangeTime);
    on<ChangeNotify>(_onChangeNotify);
    on<PressAddScheduleButton>(_onPressAddScheduleButton);
    on<SelectPlace>(_onSelectPlace);
    on<SelectRoute>(_onSelectRoute);
    on<RemoveRoute>(_onRemoveRoute);
    sinkPressSelectPlaceButtonForPlace = searchPlaceDelegateForPlace
        .pressSelectPlaceButton
        .listen((place) => add(SelectPlace(place: place)));
    sinkPressSelectPlaceButtonForRoute = searchPlaceDelegateForRoute
        .pressSelectPlaceButton
        .listen((place) => add(SelectRoute(place: place)));
  }

  @override
  Future<void> close() async {
    await sinkPressSelectPlaceButtonForPlace.cancel();
    await sinkPressSelectPlaceButtonForRoute.cancel();
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
        ? AddScheduleStatus.inComplete
        : AddScheduleStatus.complete;
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
    final Result result =
        await scheduleRepository.addSchedule(scheduleInfo: state.info);

    switch (result) {
      case Success():
        log('success!!!, statusCode : ${result.success.statusCode}');
      case Failure():
        log('fail..., statusCode : ${result.failure.statusCode}');
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