import 'dart:developer';
import 'package:earlybuddy/domain/delegate/searchplace_event_delegate.dart';
import 'package:earlybuddy/domain/repository/searchplace/searchplace_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'searchplace_event.dart';
part 'searchplace_state.dart';

final class SearchPlaceBloc extends Bloc<SearchPlaceEvent, SearchPlaceState> {
  final SearchPlaceRepository _searchPlaceRepository;
  final SearchPlaceEventDelegate _searchPlaceEventDelegate;

  SearchPlaceBloc({
    SearchPlaceRepository? searchPlaceRepository,
    SearchPlaceEventDelegate? searchPlaceEventDelegate,
    SearchPlaceState? searchPlaceState,
  })  : _searchPlaceRepository =
            searchPlaceRepository ?? SearchPlaceRepository(),
        _searchPlaceEventDelegate =
            searchPlaceEventDelegate ?? SearchPlaceEventDelegate.shared,
        super(searchPlaceState ?? SearchPlaceState()) {
    on<SearchPlaceSearchTextChanged>(
      _onSearchPlaceSearchTextChanged,
      transformer: _debounce(),
    );
    on<SearchPlaceListItemPressed>(_onSearchPlaceListItemPressed);
    on<SearchPlaceSearchButtonPressed>(_onSearchPlaceSearchButtonPressed);
    on<SearchPlaceSearchResetButtonPressed>(
        _onSearchPlaceSearchResetButtonPressed);
    on<SearchPlaceSelectPlaceButtonPressed>(
        _onSearchPlaceSelectPlaceButtonPressed);
    on<SearchPlaceCancelButtonPressed>(_onSearchPlaceCancelButtonPressed);
  }
}

extension on SearchPlaceBloc {
  void _onSearchPlaceSearchTextChanged(
    SearchPlaceSearchTextChanged event,
    Emitter<SearchPlaceState> emit,
  ) async {
    emit(state.copyWith(searchText: event.searchText));

    if (event.searchText.trim().isEmpty) {
      return;
    }

    try {
      final List<Place> places =
          await _searchPlaceRepository.getPlaces(searchText: event.searchText);
      emit(
        state.copyWith(
          status: SearchPlaceContentStatus.search,
          places: places,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          status: SearchPlaceContentStatus.search,
          places: [],
        ),
      );
    }
  }

  EventTransformer<Event> _debounce<Event>(
      {Duration duration = const Duration(milliseconds: 1000)}) {
    return (events, mapper) => events.debounce(duration).switchMap(mapper);
  }
}

extension on SearchPlaceBloc {
  void _onSearchPlaceListItemPressed(
    SearchPlaceListItemPressed event,
    Emitter<SearchPlaceState> emit,
  ) {
    emit(
      state.copyWith(
        status: SearchPlaceContentStatus.map,
        selectedPlace: event.place,
      ),
    );
  }
}

extension on SearchPlaceBloc {
  void _onSearchPlaceSearchButtonPressed(
    SearchPlaceSearchButtonPressed event,
    Emitter<SearchPlaceState> emit,
  ) async {
    if (state.searchText.trim().isEmpty) {
      return;
    }

    try {
      final List<Place> places =
          await _searchPlaceRepository.getPlaces(searchText: state.searchText);
      emit(
        state.copyWith(
          status: SearchPlaceContentStatus.search,
          places: places,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          status: SearchPlaceContentStatus.search,
          places: [],
        ),
      );
    }
  }
}

extension on SearchPlaceBloc {
  void _onSearchPlaceSearchResetButtonPressed(
    SearchPlaceSearchResetButtonPressed event,
    Emitter<SearchPlaceState> emit,
  ) {
    emit(state.copyWith(searchText: ''));
  }
}

extension on SearchPlaceBloc {
  void _onSearchPlaceSelectPlaceButtonPressed(
    SearchPlaceSelectPlaceButtonPressed event,
    Emitter<SearchPlaceState> emit,
  ) {
    _searchPlaceEventDelegate.sinkSelectPlaceButtonPressed(
      place: event.selectedPlace,
    );
  }
}

extension on SearchPlaceBloc {
  void _onSearchPlaceCancelButtonPressed(
    SearchPlaceCancelButtonPressed event,
    Emitter<SearchPlaceState> emit,
  ) {
    _searchPlaceEventDelegate.sinkCancelButtonPressed();
  }
}
