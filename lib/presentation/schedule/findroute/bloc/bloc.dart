import 'dart:developer';

import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/repository/findroute/findroute_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'states/state.dart';
part 'states/viewstates/transportlineinfo.dart';
part 'states/viewstates/viewstate.dart';

class FindRouteBloc extends Bloc<FindRouteEvent, FindRouteState> {
  final FindRouteRepository _findRouteRepository;

  FindRouteBloc({
    required Place start,
    required Place end,
    FindRouteRepository? findRouteRepository,
  })  : _findRouteRepository = findRouteRepository ?? FindRouteRepository(),
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
    try {
      // final ebRoute = await _findRouteRepository.getEBRoute(
      //   start: event.start,
      //   end: event.end,
      // );
      final ebRoute = EBRoute.mock();
      final transportLineOfRoute =
          _getTransportLineOfRoute(paths: ebRoute.ebPaths);
      final findRouteViewState =
          FindRouteViewState(transportLineOfRoute: transportLineOfRoute);
      emit(
        state.copyWith(
          ebRoute: () => ebRoute,
          viewState: findRouteViewState,
          status: FindRouteStatus.selectRoute,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          ebRoute: () => null,
          status: FindRouteStatus.nodata,
        ),
      );
    }
  }

  TransportLineOfRoute _getTransportLineOfRoute({required List<EBPath> paths}) {
    final lineOfRoute = paths.map((path) {
      return _getTransportLineOfPath(ebSubPaths: path.ebSubPaths);
    }).toList();
    return TransportLineOfRoute(lineOfRoute: lineOfRoute);
  }

  TransportLineOfPath _getTransportLineOfPath({
    required List<EBSubPath> ebSubPaths,
  }) {
    final lineOfPath = ebSubPaths
        .map((ebSubPath) => _subPathToLineInfo(ebSubPath: ebSubPath))
        .toList();
    return TransportLineOfPath(lineOfPath: lineOfPath);
  }

  TransportLineInfo _subPathToLineInfo({
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
