import 'dart:developer';

import 'package:earlybuddy/core/network/endpoint/endpoint.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/repository/findroute/findroute_repository.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
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
    FindRouteRepository? findRouteRepository,
  })  : _findRouteRepository = findRouteRepository ?? FindRouteRepository(),
        super(const FindRouteState()) {
    on<FetchFindRouteData>(_onFetchFindRouteData);
    add(const FetchFindRouteData());
  }
}

extension on FindRouteBloc {
  void _onFetchFindRouteData(
    FetchFindRouteData event,
    Emitter<FindRouteState> emit,
  ) async {
    try {
      // final ebRoute = await _findRouteRepository.getEBRoute();
      final ebRoute = EBRoute.mock();
      final transportLineOfRoute =
          _getTransportLineOfRoute(paths: ebRoute.ebPaths);
      final findRouteViewState =
          FindRouteViewState(transportLineOfRoute: transportLineOfRoute);
      emit(
        state.copyWith(ebRoute: ebRoute, viewState: findRouteViewState),
      );
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(ebRoute: null),
      );
    }
  }

  TransportLineOfRoute _getTransportLineOfRoute({required List<EBPath> paths}) {
    final lineOfRoute = paths.map((path) {
      return _getTransportLineOfPath(pair: Pair(path.time, path.ebSubPaths));
    }).toList();
    return TransportLineOfRoute(lineOfRoute: lineOfRoute);
  }

  TransportLineOfPath _getTransportLineOfPath(
      {required Pair<int, List<EBSubPath>> pair}) {
    final lineOfPath = pair.b
        .map((ebSubPath) => _subPathToLineInfo(ebSubPath: ebSubPath))
        .toList();
    return TransportLineOfPath(pathTime: pair.a, lineOfPath: lineOfPath);
  }

  TransportLineInfo _subPathToLineInfo({
    required EBSubPath ebSubPath,
  }) {
    String? name;
    Color? color;

    if (ebSubPath.type == 1) {
      final subway = ebSubPath.transports?[0].subway;
      if (subway != null) {
        name = subway.type;
        color = subway.color();
      }
    } else if (ebSubPath.type == 2) {
      final bus = ebSubPath.transports?[0].bus;
      if (bus != null) {
        name = bus.number;
        color = bus.color();
      }
    }

    return TransportLineInfo(
      name: name,
      time: ebSubPath.time,
      color: color,
    );
  }
}
