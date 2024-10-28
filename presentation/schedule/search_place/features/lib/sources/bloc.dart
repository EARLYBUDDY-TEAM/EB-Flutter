part of '../eb_search_place_feature.dart';

final class SearchPlaceBloc extends Bloc<SearchPlaceEvent, SearchPlaceState> {
  final AddScheduleDelegate _addScheduleDelegate;
  final FindRouteDelegate _findRouteDelegate;
  final SearchPlaceRepository _searchPlaceRepository;
  final Function() _navigatorOfPopAction;

  SearchPlaceBloc({
    required AddScheduleDelegate addScheduleDelegate,
    required FindRouteDelegate findRouteDelegate,
    required SearchPlaceRepository searchPlaceRepository,
    required SearchPlaceState searchPlaceState,
    required Function() navigatorOfPopAction,
  })  : _findRouteDelegate = findRouteDelegate,
        _addScheduleDelegate = addScheduleDelegate,
        _searchPlaceRepository = searchPlaceRepository,
        _navigatorOfPopAction = navigatorOfPopAction,
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
    on<SetSearchPlaceContentStatus>(_onSetSearchPlaceContentStatus);
  }

  @override
  Future<void> close() async {
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
    final contentStatus = ListSearchPlaceContent(placeList: const []);
    emit(
      state.copyWith(
        placeList: [],
        contentStatus: contentStatus,
        searchText: "",
      ),
    );
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
      case ChangeEndSearchPlaceSetting():
        _findRouteDelegate.changeEndPlace.add(event.selectedPlace);
      case ChangeStartSearchPlaceSetting():
        _findRouteDelegate.changeStartPlace.add(event.selectedPlace);
      default:
    }
  }
}

extension on SearchPlaceBloc {
  void _onPressCancelButton(
    PressCancelButton event,
    Emitter<SearchPlaceState> emit,
  ) {
    switch (state.setting) {
      case (EndSearchPlaceSetting() || StartSearchPlaceSetting()):
        _addScheduleDelegate.cancelModalView.add(());
      default:
        _navigatorOfPopAction();
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
        final List<Place> placeList = result.success.model;
        emit(
          state.copyWith(
            placeList: placeList,
            contentStatus: ListSearchPlaceContent(placeList: placeList),
          ),
        );
      case Failure():
        emit(
          state.copyWith(
            placeList: [],
            contentStatus: ListSearchPlaceContent(placeList: const []),
          ),
        );
    }
  }
}

extension on SearchPlaceBloc {
  void _onSetSearchPlaceContentStatus(
    SetSearchPlaceContentStatus event,
    Emitter<SearchPlaceState> emit,
  ) {
    emit(state.copyWith(contentStatus: event.contentStatus));
  }
}
