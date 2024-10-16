part of '../eb_search_place_feature.dart';

final class SearchPlaceBloc extends Bloc<SearchPlaceEvent, SearchPlaceState> {
  final AddScheduleDelegate _addScheduleDelegate;
  final SearchPlaceRepository _searchPlaceRepository;

  final Function() _backFindRouteViewAction;

  late StreamSubscription<void> _backFindRouteViewSubscription;

  SearchPlaceBloc({
    required SearchPlaceDelegate searchPlaceDelegate,
    required AddScheduleDelegate addScheduleDelegate,
    required SearchPlaceRepository searchPlaceRepository,
    required SearchPlaceState searchPlaceState,
    required Function() backFindRouteViewAction,
  })  : _addScheduleDelegate = addScheduleDelegate,
        _searchPlaceRepository = searchPlaceRepository,
        _backFindRouteViewAction = backFindRouteViewAction,
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

    _backFindRouteViewSubscription = searchPlaceDelegate.backFindRouteView
        .listen((_) => _backFindRouteViewAction());
  }

  @override
  Future<void> close() async {
    await _backFindRouteViewSubscription.cancel();
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
    emit(state.copyWith(
      selectedPlace: event.place,
      contentStatus: SearchPlaceContentStatus.map,
    ));
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
    emit(state.copyWith(
      contentStatus: SearchPlaceContentStatus.search,
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
    switch (state.setting) {
      case EndSearchPlaceSetting():
        _addScheduleDelegate.cancelEndSearchPlaceView.add(());
      case StartSearchPlaceSetting():
        _addScheduleDelegate.cancelStartSearchPlaceView.add(());
    }
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
        final List<Place> places = result.success.model;
        emit(
          state.copyWith(
            places: places,
            contentStatus: SearchPlaceContentStatus.search,
          ),
        );
      case Failure():
        emit(
          state.copyWith(
            places: [],
            contentStatus: SearchPlaceContentStatus.search,
          ),
        );
    }
  }
}
