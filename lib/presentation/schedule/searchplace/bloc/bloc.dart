import 'package:earlybuddy/domain/delegate/searchplace_delegate.dart';
import 'package:earlybuddy/domain/repository/repository.dart';
import 'package:earlybuddy/shared/eb_model/entity/entity.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_sources.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'event.dart';
part 'state.dart';
part 'viewstate.dart';

final class SearchPlaceBloc extends Bloc<SearchPlaceEvent, SearchPlaceState> {
  final SearchPlaceDelegate _delegate;
  final SearchPlaceRepository _searchPlaceRepository;
  Function(Place) selectAction;
  Function() cancelAction;

  SearchPlaceBloc({
    required SearchPlaceDelegate delegate,
    required SearchPlaceSetting setting,
    SearchPlaceRepository? searchPlaceRepository,
    SearchPlaceState? searchPlaceState,
    Function(Place)? selectAction,
    Function()? cancelAction,
  })  : _delegate = delegate,
        _searchPlaceRepository =
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
    _delegate.addPressSelectPlaceButton(event.selectedPlace);
    selectAction(event.selectedPlace);
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
        final viewState = state.viewState
            .copyWith(contentStatus: SearchPlaceContentStatus.search);
        emit(
          state.copyWith(
            places: places,
            viewState: viewState,
          ),
        );
      case Failure():
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
}
