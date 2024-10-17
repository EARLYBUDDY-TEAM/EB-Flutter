part of '../eb_search_place_feature.dart';

final class SearchPlaceBloc extends Bloc<SearchPlaceEvent, SearchPlaceState> {
  final AddScheduleDelegate _addScheduleDelegate;
  final SearchPlaceRepository _searchPlaceRepository;

  final Function() _backFromFindRouteViewAction;

  late StreamSubscription<void> _backFromFindRouteViewSubscription;

  SearchPlaceBloc({
    required SearchPlaceDelegate searchPlaceDelegate,
    required AddScheduleDelegate addScheduleDelegate,
    required SearchPlaceRepository searchPlaceRepository,
    required SearchPlaceState searchPlaceState,
    required Function() backFromFindRouteViewAction,
  })  : _addScheduleDelegate = addScheduleDelegate,
        _searchPlaceRepository = searchPlaceRepository,
        _backFromFindRouteViewAction = backFromFindRouteViewAction,
        super(searchPlaceState) {
    on<ChangeSearchText>(
      _onChangeSearchText,
      transformer: _debounce(),
    );
    on<PressListItem>(_onPressListItem);
    on<PressSearchButton>(_onPressSearchButton);
    on<PressResetButton>(_onPressResetButton);
    on<PressSelectPlaceButton>(_onPressSelectPlaceButton);
    on<PressCancelButton>(_onPressCancelButton);

    _backFromFindRouteViewSubscription = searchPlaceDelegate
        .backFromFindRouteView
        .listen((_) => _backFromFindRouteViewAction());
  }

  @override
  Future<void> close() async {
    await _backFromFindRouteViewSubscription.cancel();
    await super.close();
  }
}

extension on SearchPlaceBloc {
  Future<void> _onChangeSearchText(
    ChangeSearchText event,
    Emitter<SearchPlaceState> emit,
  ) async {
    emit(state.copyWith(searchText: event.searchText));
    await getPlaces(event.searchText, emit);
  }

  EventTransformer<Event> _debounce<Event>(
      {Duration duration = const Duration(milliseconds: 1000)}) {
    return (events, mapper) => events.debounce(duration).switchMap(mapper);
  }
}

extension on SearchPlaceBloc {
  void _onPressListItem(
    PressListItem event,
    Emitter<SearchPlaceState> emit,
  ) {
    final contentStatus = MapSearchPlaceContent(selectedPlace: event.place);
    emit(
      state.copyWith(
        contentStatus: contentStatus,
      ),
    );
  }
}

extension on SearchPlaceBloc {
  Future<void> _onPressSearchButton(
    PressSearchButton event,
    Emitter<SearchPlaceState> emit,
  ) async {
    await getPlaces(state.searchText, emit);
  }
}

extension on SearchPlaceBloc {
  void _onPressResetButton(
    PressResetButton event,
    Emitter<SearchPlaceState> emit,
  ) {
    final contentStatus = ListSearchPlaceContent();
    emit(state.copyWith(
      contentStatus: contentStatus,
      searchText: "",
    ));
  }
}

extension on SearchPlaceBloc {
  void _onPressSelectPlaceButton(
    PressSelectPlaceButton event,
    Emitter<SearchPlaceState> emit,
  ) {
    switch (state.setting) {
      case EndSearchPlaceSetting():
        _addScheduleDelegate.selectEndPlace.add(event.selectedPlace);
      case StartSearchPlaceSetting():
        _addScheduleDelegate.selectStartPlace.add(event.selectedPlace);
    }
  }
}

extension on SearchPlaceBloc {
  void _onPressCancelButton(
    PressCancelButton event,
    Emitter<SearchPlaceState> emit,
  ) {
    _addScheduleDelegate.cancelModalView.add(());
  }
}

extension on SearchPlaceBloc {
  Future<void> getPlaces(
    String searchText,
    Emitter<SearchPlaceState> emit,
  ) async {
    if (searchText.trim().isEmpty) {
      return;
    }

    final Result result =
        await _searchPlaceRepository.getPlaces(searchText: searchText);

    switch (result) {
      case Success():
        final List<Place> placeList = result.success.model;
        final contentStatus = ListSearchPlaceContent(placeList: placeList);
        emit(state.copyWith(contentStatus: contentStatus));
      case Failure():
        emit(state.copyWith(contentStatus: ListSearchPlaceContent()));
    }
  }
}
