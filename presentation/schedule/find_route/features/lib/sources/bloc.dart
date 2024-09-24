part of '../eb_find_route_feature.dart';

class FindRouteBloc extends Bloc<FindRouteEvent, FindRouteState> {
  final FindRouteRepository _findRouteRepository;

  FindRouteBloc({
    required Place start,
    required Place end,
    required FindRouteRepository findRouteRepository,
  })  : _findRouteRepository = findRouteRepository,
        super(const FindRouteState()) {
    on<FetchFindRouteData>(_onFetchFindRouteData);
    on<setFindRouteStatus>(_onSetFindRouteStatus);

    add(FetchFindRouteData(start: start, end: end));
  }
}

extension on FindRouteBloc {
  void _onSetFindRouteStatus(
    setFindRouteStatus event,
    Emitter<FindRouteState> emit,
  ) {
    emit(state.copyWith(status: event.status));
  }
}

extension on FindRouteBloc {
  void _onFetchFindRouteData(
    FetchFindRouteData event,
    Emitter<FindRouteState> emit,
  ) async {
    final Result result = await _findRouteRepository.getEBRoute(
      start: event.start,
      end: event.end,
    );

    // final ebRoute = EBRoute.mock();

    switch (result) {
      case Success():
        final ebRoute = result.success.model;
        final transportLineOfRoute =
            getTransportLineOfRoute(paths: ebRoute.ebPaths);
        final findRouteViewState =
            FindRouteViewState(transportLineOfRoute: transportLineOfRoute);
        emit(
          state.copyWith(
            ebRoute: () => ebRoute,
            viewState: findRouteViewState,
            status: FindRouteStatus.selectRoute,
          ),
        );
      case Failure():
        log(result.failure.statusCode.toString());
        emit(
          state.copyWith(
            ebRoute: () => null,
            status: FindRouteStatus.nodata,
          ),
        );
    }
  }

  TransportLineOfRoute getTransportLineOfRoute({required List<EBPath> paths}) {
    final lineOfRoute = paths.map((path) {
      return getTransportLineOfPath(ebSubPaths: path.ebSubPaths);
    }).toList();
    return TransportLineOfRoute(lineOfRoute: lineOfRoute);
  }

  TransportLineOfPath getTransportLineOfPath({
    required List<EBSubPath> ebSubPaths,
  }) {
    final lineOfPath = ebSubPaths
        .map((ebSubPath) => subPathToLineInfo(ebSubPath: ebSubPath))
        .toList();
    return TransportLineOfPath(lineOfPath: lineOfPath);
  }

  TransportLineInfo subPathToLineInfo({
    required EBSubPath ebSubPath,
  }) {
    String name = '';
    Color? color;

    if (ebSubPath.type == 1) {
      final subway = ebSubPath.transports[0].subway;
      if (subway != null) {
        name = subway.type;
        color = subway.color();
      }
    } else if (ebSubPath.type == 2) {
      final bus = ebSubPath.transports[0].bus;
      if (bus != null) {
        name = bus.number;
        color = bus.color();
      }
    } else {
      name = '${ebSubPath.time}분';
    }

    return TransportLineInfo(
      name: name,
      time: ebSubPath.time,
      color: color,
    );
  }
}
