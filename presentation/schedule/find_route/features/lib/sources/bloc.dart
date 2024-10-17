part of '../eb_find_route_feature.dart';

final class FindRouteBloc extends Bloc<FindRouteEvent, FindRouteState> {
  final AddScheduleDelegate _addScheduleDelegate;
  final SearchPlaceDelegate _searchPlaceDelegate;
  final FindRouteRepository _findRouteRepository;

  FindRouteBloc({
    required Place startPlace,
    required Place endPlace,
    required AddScheduleDelegate addScheduleDelegate,
    required SearchPlaceDelegate searchPlaceDelegate,
    required FindRouteRepository findRouteRepository,
  })  : _addScheduleDelegate = addScheduleDelegate,
        _searchPlaceDelegate = searchPlaceDelegate,
        _findRouteRepository = findRouteRepository,
        super(FindRouteState(startPlace: startPlace, endPlace: endPlace)) {
    on<GetRouteData>(_onFetchFindRouteData);
    on<SetFindRouteContentStatus>(_onSetFindRouteContentStatus);
    on<OnAppearFindRouteView>(_onOnAppearFindRouteView);
    on<BackViewAction>(_onBackViewAction);
    on<CancelViewAction>(_onCancelViewAction);
  }
}

extension on FindRouteBloc {
  void _onSetFindRouteContentStatus(
    SetFindRouteContentStatus event,
    Emitter<FindRouteState> emit,
  ) {
    emit(state.copyWith(contentStatus: event.contentStatus));
  }
}

extension on FindRouteBloc {
  void _onFetchFindRouteData(
    GetRouteData event,
    Emitter<FindRouteState> emit,
  ) async {
    final Result result = await _findRouteRepository.getEBRoute(
      start: state.startPlace,
      end: state.endPlace,
    );

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
            contentStatus: SelectFindRouteStatus(),
          ),
        );
      case Failure():
        log(result.failure.statusCode.toString());
        emit(
          state.copyWith(
            ebRoute: () => null,
            contentStatus: EmptyDataFindRouteStatus(),
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

extension on FindRouteBloc {
  void _onOnAppearFindRouteView(
    OnAppearFindRouteView event,
    Emitter<FindRouteState> emit,
  ) {
    add(const GetRouteData());
  }
}

extension on FindRouteBloc {
  void _onBackViewAction(
    BackViewAction event,
    Emitter<FindRouteState> emit,
  ) {
    _searchPlaceDelegate.backFromFindRouteView.add(());
  }
}

extension on FindRouteBloc {
  void _onCancelViewAction(
    CancelViewAction event,
    Emitter<FindRouteState> emit,
  ) {
    _addScheduleDelegate.cancelModalView.add(());
  }
}
