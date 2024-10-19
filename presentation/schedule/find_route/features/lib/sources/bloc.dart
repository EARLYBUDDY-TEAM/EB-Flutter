part of '../eb_find_route_feature.dart';

final class FindRouteBloc extends Bloc<FindRouteEvent, FindRouteState> {
  final AddScheduleDelegate _addScheduleDelegate;
  final FindRouteRepository _findRouteRepository;

  late StreamSubscription<Place> changeStartPlaceSubscription;
  late StreamSubscription<Place> changeEndPlaceSubscription;

  FindRouteBloc({
    required AddScheduleDelegate addScheduleDelegate,
    required FindRouteDelegate findRouteDelegate,
    required FindRouteRepository findRouteRepository,
    required FindRouteState findRouteState,
  })  : _addScheduleDelegate = addScheduleDelegate,
        _findRouteRepository = findRouteRepository,
        super(findRouteState) {
    on<GetRouteData>(_onFetchFindRouteData);
    on<SetFindRouteContentStatus>(_onSetFindRouteContentStatus);
    on<OnAppearFindRouteView>(_onOnAppearFindRouteView);
    on<CancelViewAction>(_onCancelViewAction);
    on<SetSearchPlaceInfo>(_onSetSearchPlaceInfo);
    on<PressSelectRouteButton>(_onPressSelectRouteButton);

    changeStartPlaceSubscription = findRouteDelegate.changeStartPlace.listen(
      (startPlace) => add(SetSearchPlaceInfo(startPlace: startPlace)),
    );
    changeEndPlaceSubscription = findRouteDelegate.changeEndPlace.listen(
      (endPlace) => add(SetSearchPlaceInfo(endPlace: endPlace)),
    );
  }

  @override
  Future<void> close() async {
    await changeStartPlaceSubscription.cancel();
    await changeEndPlaceSubscription.cancel();
    await super.close();
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
      start: state.searchPlaceInfo.startPlace,
      end: state.searchPlaceInfo.endPlace,
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
  void _onCancelViewAction(
    CancelViewAction event,
    Emitter<FindRouteState> emit,
  ) {
    _addScheduleDelegate.cancelModalView.add(());
  }
}

extension on FindRouteBloc {
  void _onSetSearchPlaceInfo(
    SetSearchPlaceInfo event,
    Emitter<FindRouteState> emit,
  ) {
    final searchPlaceInfo = state.searchPlaceInfo.copyWith(
      startPlace: event.startPlace,
      endPlace: event.endPlace,
    );
    emit(
      state.copyWith(
        searchPlaceInfo: searchPlaceInfo,
      ),
    );
    add(const GetRouteData());
  }
}

extension on FindRouteBloc {
  void _onPressSelectRouteButton(
    PressSelectRouteButton event,
    Emitter<FindRouteState> emit,
  ) {
    final contentStatus = state.contentStatus;

    if ((contentStatus is! DetailFindRouteStatus) || (state.ebRoute == null)) {
      return;
    }

    final startPlace = state.searchPlaceInfo.startPlace;
    final endPlace = state.searchPlaceInfo.endPlace;
    final index = contentStatus.selectedIndex;
    final lineOfPath =
        state.viewState.transportLineOfRoute.lineOfRoute[index].lineOfPath;
    final transportLineOfPath = TransportLineOfPath(lineOfPath: lineOfPath);
    final ebPath = state.ebRoute!.ebPaths[index];
    final pathInfo = PathInfo(
      startPlace: startPlace,
      endPlace: endPlace,
      transportLineOfPath: transportLineOfPath,
      ebPath: ebPath,
    );
    _addScheduleDelegate.selectStartPlace.add(pathInfo);
    _addScheduleDelegate.cancelModalView.add(());
  }
}
