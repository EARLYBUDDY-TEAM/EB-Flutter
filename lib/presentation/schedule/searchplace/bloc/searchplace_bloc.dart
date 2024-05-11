import 'dart:developer';
import 'package:earlybuddy/domain/searchplace/searchplace_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'searchplace_event.dart';
part 'searchplace_state.dart';

final class SearchPlaceBloc extends Bloc<SearchPlaceEvent, SearchPlaceState> {
  final SearchPlaceRepository _searchPlaceRepository;

  SearchPlaceBloc({
    SearchPlaceRepository? searchPlaceRepository,
    SearchPlaceState? searchPlaceState,
  })  : _searchPlaceRepository =
            searchPlaceRepository ?? SearchPlaceRepository(),
        super(searchPlaceState ?? SearchPlaceState()) {
    on<SearchPlaceSearchTextChanged>(
      _onSearchPlaceSearchTextChanged,
      transformer: _debounce(),
    );
  }
}

extension on SearchPlaceBloc {
  void _onSearchPlaceSearchTextChanged(
    SearchPlaceSearchTextChanged event,
    Emitter<SearchPlaceState> emit,
  ) async {
    try {
      final List<Place> places =
          await _searchPlaceRepository.getPlaces(searchText: event.searchText);
      emit(state.copyWith(places: places));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(places: []));
    }
  }

  EventTransformer<Event> _debounce<Event>(
      {Duration duration = const Duration(milliseconds: 1000)}) {
    return (events, mapper) => events.debounce(duration).switchMap(mapper);
  }
}
