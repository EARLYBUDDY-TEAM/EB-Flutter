part of '../../detailroute_feature.dart';

final class DetailRouteBloc extends Bloc<DetailRouteEvent, DetailRouteState> {
  DetailRouteBloc({
    required Transport? selectedTransport,
  }) : super(
          DetailRouteState(
            selectedTransport: selectedTransport,
          ),
        ) {
    on<SelectTransport>(_onSelectTransport);
  }

  void _onSelectTransport(
    SelectTransport event,
    Emitter<DetailRouteState> emit,
  ) {
    final selectedTransport = event.selected;
    emit(
      state.copyWith(selectedTransport: () => selectedTransport),
    );
  }
}
