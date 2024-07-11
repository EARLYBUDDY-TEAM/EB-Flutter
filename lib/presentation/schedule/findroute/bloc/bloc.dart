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
    FindRouteRepository? findRouteRepository,
  })  : _findRouteRepository = findRouteRepository ?? FindRouteRepository(),
        super(const FindRouteState()) {
    on<FetchFindRouteData>(_onFetchFindRouteData);
    add(const FetchFindRouteData());
  }

  void fetchFindRouteData() {}
}

// shared 이동
class Pair<T1, T2> {
  final T1 a;
  final T2 b;

  Pair(this.a, this.b);
}

extension on FindRouteBloc {
  void _onFetchFindRouteData(
    FetchFindRouteData event,
    Emitter<FindRouteState> emit,
  ) async {
    try {
      final ebRoute = await _findRouteRepository.getEBRoute();
      final transportLineOfRoute =
          getTransportLineOfRoute(paths: ebRoute.ebPaths);
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

  TransportLineOfRoute getTransportLineOfRoute({required List<EBPath> paths}) {
    final lineOfRoute = paths.map((path) {
      return getTransportLineOfPath(pair: Pair(path.time, path.ebSubPaths));
    }).toList();
    return TransportLineOfRoute(lineOfRoute: lineOfRoute);
  }

  TransportLineOfPath getTransportLineOfPath(
      {required Pair<int, List<EBSubPath>> pair}) {
    final lineOfPath = pair.b
        .map((ebSubPath) => subPathToLineInfo(ebSubPath: ebSubPath))
        .toList();
    return TransportLineOfPath(pathTime: pair.a, lineOfPath: lineOfPath);
  }

  TransportLineInfo subPathToLineInfo({
    required EBSubPath ebSubPath,
  }) {
    String? name;
    Color? color;

    if (ebSubPath.type == 1) {
      try {
        name = ebSubPath.transports?[0].subwayName;
        // color = ebSubPath.transports?[0].color
        color = Colors.green;
      } catch (e) {}
    } else if (ebSubPath.type == 2) {
      try {
        name = ebSubPath.transports?[0].busName;
        // color = ebSubPath.transports?[0].color
        color = Colors.yellow;
      } catch (e) {}
    }
    return TransportLineInfo(
      type: ebSubPath.type,
      name: name,
      subPathTime: ebSubPath.time,
      color: color,
    );
  }
}
