part of '../eb_find_route_feature.dart';

final class FindRouteBloc extends Bloc<FindRouteEvent, FindRouteState> {
  final LoadingDelegate _loadingDelegate;
  final AddScheduleDelegate _addScheduleDelegate;
  final FindRouteRepository _findRouteRepository;

  late StreamSubscription<Place> changeStartPlaceSubscription;
  late StreamSubscription<Place> changeEndPlaceSubscription;

  FindRouteBloc({
    required LoadingDelegate loadingDelegate,
    required AddScheduleDelegate addScheduleDelegate,
    required FindRouteDelegate findRouteDelegate,
    required FindRouteRepository findRouteRepository,
    required FindRouteState findRouteState,
  })  : _loadingDelegate = loadingDelegate,
        _addScheduleDelegate = addScheduleDelegate,
        _findRouteRepository = findRouteRepository,
        super(findRouteState) {
    on<GetRouteData>(_onGetRouteData);
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
  void _onGetRouteData(
    GetRouteData event,
    Emitter<FindRouteState> emit,
  ) async {
    _loadingDelegate.set();

    final Result result = await _findRouteRepository.getEBRoute(
      start: state.searchPlaceInfo.startPlace,
      end: state.searchPlaceInfo.endPlace,
    );

    switch (result) {
      case Success():
        final EBRoute ebRoute = result.success.model;
        final transportLineOfRoute =
            getTransportLineOfRoute(paths: ebRoute.ebPaths);
        final routeInfo = RouteInfo(
          ebRoute: ebRoute,
          transportLineOfRoute: transportLineOfRoute,
        );

        final contentStatus = state.createSelectContentStatus(
          routeInfo: routeInfo,
        );

        emit(
          state.copyWith(
            routeInfo: routeInfo,
            contentStatus: contentStatus,
          ),
        );
      case Failure():
        log(result.failure.statusCode.toString());
        emit(
          state.copyWith(
            routeInfo: const RouteInfo(),
            contentStatus: EmptyDataFindRouteStatus(),
          ),
        );
    }

    _loadingDelegate.dismiss();
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

    if ((contentStatus is! DetailFindRouteStatus) ||
        (state.routeInfo.ebRoute == null)) {
      return;
    }

    final startPlace = state.searchPlaceInfo.startPlace;
    final endPlace = state.searchPlaceInfo.endPlace;
    final index = contentStatus.selectedIndex;
    final lineOfPath =
        state.routeInfo.transportLineOfRoute.lineOfRoute[index].lineOfPath;
    final transportLineOfPath = TransportLineOfPath(lineOfPath: lineOfPath);
    final ebPath = state.routeInfo.ebRoute.ebPaths[index];
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
