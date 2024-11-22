part of '../../detailroute_feature.dart';

final class DetailRouteBloc extends Bloc<DetailRouteEvent, DetailRouteState> {
  final RealTimeInfoEvent _realTimeInfoEvent;

  DetailRouteBloc({
    required RealTimeInfoEvent realTimeInfoEvent,
  })  : _realTimeInfoEvent = realTimeInfoEvent,
        super(const DetailRouteState()) {
    on<SelectTransport>(_onSelectTransport);
    on<SetupDetailRoute>(_onSetupDetailRoute);
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

  Future<void> _onSetupDetailRoute(
    SetupDetailRoute event,
    Emitter<DetailRouteState> emit,
  ) async {
    final subPath = event.subPath;
    final selectedTransport = subPath.transportList.firstOrNull;
    final streamRealTimeInfo =
        await _realTimeInfoEvent.makeStreamRealTimeInfo(subPath: subPath);

    emit(
      state.copyWith(
        selectedTransport: () => selectedTransport,
        streamRealTimeInfo: () => streamRealTimeInfo,
      ),
    );
  }
}
