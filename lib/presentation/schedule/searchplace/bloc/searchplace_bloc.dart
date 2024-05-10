import 'dart:developer';

import 'package:earlybuddy/domain/searchplace/searchplace_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'searchplace_event.dart';
part 'searchplace_state.dart';

final class SearchPlaceBloc extends Bloc<SearchPlaceEvent, SearchPlaceState> {
  final SearchPlaceRepository _searchPlaceRepository;

  SearchPlaceBloc({SearchPlaceRepository? searchPlaceRepository})
      : _searchPlaceRepository =
            searchPlaceRepository ?? SearchPlaceRepository(),
        super(SearchPlaceState()) {
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
    log(event.searchText);
    final List<Place> places =
        await _searchPlaceRepository.getPlaces(searchText: event.searchText);
    log(places.toString());
    emit(state.copyWith(places: places));
  }

  EventTransformer<Event> _debounce<Event>(
      {Duration duration = const Duration(milliseconds: 1000)}) {
    return (events, mapper) => events.debounce(duration).switchMap(mapper);
  }
}
