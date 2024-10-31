part of '../eb_find_route_feature.dart';

final class FindRouteBloc extends Bloc<FindRouteEvent, FindRouteState> {
  final LoadingDelegate _loadingDelegate;
  final AddScheduleDelegate _addScheduleDelegate;
  final HomeDelegate _homeDelegate;
  final FindRouteRepository _findRouteRepository;
  final ScheduleEvent _scheduleEvent;

  late StreamSubscription<Place> changeStartPlaceSubscription;
  late StreamSubscription<Place> changeEndPlaceSubscription;

  FindRouteBloc({
    required LoadingDelegate loadingDelegate,
    required AddScheduleDelegate addScheduleDelegate,
    required HomeDelegate homeDelegate,
    required FindRouteDelegate findRouteDelegate,
    required FindRouteRepository findRouteRepository,
    required ScheduleEvent scheduleEvent,
    required FindRouteState findRouteState,
  })  : _loadingDelegate = loadingDelegate,
        _addScheduleDelegate = addScheduleDelegate,
        _homeDelegate = homeDelegate,
        _findRouteRepository = findRouteRepository,
        _scheduleEvent = scheduleEvent,
        super(findRouteState) {
    on<GetRouteData>(_onGetRouteData);
    on<SetFindRouteContentStatus>(_onSetFindRouteContentStatus);
    on<CancelViewAction>(_onCancelViewAction);
    on<SetSearchPlaceInfo>(_onSetSearchPlaceInfo);
    on<PressSelectRouteButton>(_onPressSelectRouteButton);
    on<SetupFindRouteView>(_onSetupFindRouteView);
    on<SetUpdateResult>(_onSetUpdateResult);

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
    if ((state.searchPlaceInfo.startPlace == null) ||
        (state.searchPlaceInfo.endPlace == null)) {
      return;
    }

    _loadingDelegate.set();

    final Result result = await _findRouteRepository.getEBRoute(
      start: state.searchPlaceInfo.startPlace!,
      end: state.searchPlaceInfo.endPlace!,
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
  void _onCancelViewAction(
    CancelViewAction event,
    Emitter<FindRouteState> emit,
  ) {
    final setting = state.setting;
    switch (setting) {
      case ReadFindRouteSetting():
        _homeDelegate.cancelModalView.add(());
      case WriteFindRouteSetting():
        _addScheduleDelegate.cancelModalView.add(());
      case WriteAndUpdateFindRouteSetting():
        _homeDelegate.cancelModalView.add(());
    }
  }
}

extension on FindRouteBloc {
  void _onSetSearchPlaceInfo(
    SetSearchPlaceInfo event,
    Emitter<FindRouteState> emit,
  ) {
    final searchPlaceInfo = state.searchPlaceInfo.copyWith(
      startPlace: (event.startPlace != null) ? () => event.startPlace : null,
      endPlace: (event.endPlace != null) ? () => event.endPlace : null,
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
  Future<void> _onPressSelectRouteButton(
    PressSelectRouteButton event,
    Emitter<FindRouteState> emit,
  ) async {
    final startPlace = state.searchPlaceInfo.startPlace;
    final endPlace = state.searchPlaceInfo.endPlace;
    if ((startPlace == null) || (endPlace == null)) {
      return;
    }

    final contentStatus = state.contentStatus;
    if (contentStatus is! DetailFindRouteStatus) {
      return;
    }

    final setting = state.setting;
    switch (setting) {
      case WriteFindRouteSetting():
        _selectRoute(
          contentStatus: contentStatus,
          startPlace: startPlace,
          endPlace: endPlace,
        );
      case WriteAndUpdateFindRouteSetting():
        final schedule = setting.schedulePath.schedule.copyWith(
          startPlace: () => startPlace,
          endPlace: () => endPlace,
        );
        final index = contentStatus.selectedIndex;
        final ebPath = state.routeInfo.ebRoute.ebPaths[index];
        successAction() {
          add(const SetUpdateResult(result: BaseStatus.success));
          _homeDelegate.getAllSchedules.add(());
        }
        failAction() {
          add(const SetUpdateResult(result: BaseStatus.fail));
        }
        await _scheduleEvent.update(
          schedule: schedule,
          ebPath: ebPath,
          successAction: successAction,
          failAction: failAction,
        );

      case ReadFindRouteSetting():
        return;
    }
  }

  void _selectRoute({
    required DetailFindRouteStatus contentStatus,
    required Place startPlace,
    required Place endPlace,
  }) {
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

extension on FindRouteBloc {
  void _onSetupFindRouteView(
    SetupFindRouteView event,
    Emitter<FindRouteState> emit,
  ) {
    final setting = event.setting;

    switch (setting) {
      case ReadFindRouteSetting():
        final contentStatus = DetailFindRouteStatus(
          selectedIndex: 0,
          path: setting.path,
        );
        add(SetFindRouteContentStatus(contentStatus: contentStatus));
      case WriteFindRouteSetting():
        add(const GetRouteData());
      case WriteAndUpdateFindRouteSetting():
        final contentStatus = EmptyDataFindRouteStatus();
        add(SetFindRouteContentStatus(contentStatus: contentStatus));
    }
  }
}

extension on FindRouteBloc {
  void _onSetUpdateResult(
    SetUpdateResult event,
    Emitter<FindRouteState> emit,
  ) {
    emit(state.copyWith(updateResult: event.result));
  }
}
