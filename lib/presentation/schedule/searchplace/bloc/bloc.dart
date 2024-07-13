import 'dart:developer';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/repository/searchplace/searchplace_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'event.dart';
part 'state.dart';
part 'viewstate.dart';

final class SearchPlaceBloc extends Bloc<SearchPlaceEvent, SearchPlaceState> {
  final SearchPlaceRepository _searchPlaceRepository;
  Function(Place) selectAction;
  Function() cancelAction;

  SearchPlaceBloc({
    SearchPlaceSetting setting = SearchPlaceSetting.departure,
    SearchPlaceRepository? searchPlaceRepository,
    SearchPlaceState? searchPlaceState,
    Function(Place)? selectAction,
    Function()? cancelAction,
  })  : _searchPlaceRepository =
            searchPlaceRepository ?? SearchPlaceRepository(),
        selectAction = selectAction ?? ((_) {}),
        cancelAction = cancelAction ?? (() {}),
        super(searchPlaceState ?? SearchPlaceState()) {
    final viewState = state.viewState.copyWith(setting: setting);
    emit(state.copyWith(viewState: viewState));

    on<ChangeSearchText>(
      _onChangeSearchText,
      transformer: _debounce(),
    );
    on<PressListItem>(_onPressListItem);
    on<PressSearchButton>(_onPressSearchButton);
    on<PressResetButton>(_onPressResetButton);
    on<PressSelectPlaceButton>(_onPressSelectPlaceButton);
    on<PressCancelButton>(_onPressCancelButton);
  }
}

extension on SearchPlaceBloc {
  void _onChangeSearchText(
    ChangeSearchText event,
    Emitter<SearchPlaceState> emit,
  ) async {
    emit(state.copyWith(searchText: event.searchText));

    if (event.searchText.trim().isEmpty) {
      return;
    }

    try {
      final List<Place> places =
          await _searchPlaceRepository.getPlaces(searchText: event.searchText);
      final viewState = state.viewState
          .copyWith(contentStatus: SearchPlaceContentStatus.search);
      emit(
        state.copyWith(
          places: places,
          viewState: viewState,
        ),
      );
    } catch (e) {
      log(e.toString());
      final viewState = state.viewState
          .copyWith(contentStatus: SearchPlaceContentStatus.search);
      emit(
        state.copyWith(
          places: [],
          viewState: viewState,
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
  void _onPressListItem(
    PressListItem event,
    Emitter<SearchPlaceState> emit,
  ) {
    final viewState =
        state.viewState.copyWith(contentStatus: SearchPlaceContentStatus.map);
    emit(
      state.copyWith(
        selectedPlace: event.place,
        viewState: viewState,
      ),
    );
  }
}

extension on SearchPlaceBloc {
  void _onPressSearchButton(
    PressSearchButton event,
    Emitter<SearchPlaceState> emit,
  ) async {
    if (state.searchText.trim().isEmpty) {
      return;
    }

    try {
      final List<Place> places =
          await _searchPlaceRepository.getPlaces(searchText: state.searchText);
      final viewState =
          state.viewState.copyWith(contentStatus: SearchPlaceContentStatus.map);
      emit(
        state.copyWith(
          places: places,
          viewState: viewState,
        ),
      );
    } catch (e) {
      log(e.toString());
      final viewState =
          state.viewState.copyWith(contentStatus: SearchPlaceContentStatus.map);
      emit(
        state.copyWith(
          places: [],
          viewState: viewState,
        ),
      );
    }
  }
}

extension on SearchPlaceBloc {
  void _onPressResetButton(
    PressResetButton event,
    Emitter<SearchPlaceState> emit,
  ) {
    final viewState = state.viewState
        .copyWith(contentStatus: SearchPlaceContentStatus.search);
    emit(state.copyWith(
      searchText: '',
      viewState: viewState,
    ));
  }
}

extension on SearchPlaceBloc {
  void _onPressSelectPlaceButton(
    PressSelectPlaceButton event,
    Emitter<SearchPlaceState> emit,
  ) {
    selectAction(event.selectedPlace);
    cancelAction();
  }
}

extension on SearchPlaceBloc {
  void _onPressCancelButton(
    PressCancelButton event,
    Emitter<SearchPlaceState> emit,
  ) {
    cancelAction();
  }
}
