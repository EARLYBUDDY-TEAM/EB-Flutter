import 'dart:developer';

import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/repository/findroute/findroute_repository.dart';
import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
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

  final Map<String, Color> _subwayColor = {
    '1호선': EBColors.subway.line1,
    '2호선': EBColors.subway.line2,
    '3호선': EBColors.subway.line3,
    '4호선': EBColors.subway.line4,
    '5호선': EBColors.subway.line5,
    '6호선': EBColors.subway.line6,
    '7호선': EBColors.subway.line7,
    '8호선': EBColors.subway.line8,
    '9호선': EBColors.subway.line9,
    '인천1호선': EBColors.subway.incheon1,
    '인천2호선': EBColors.subway.incheon2,
    '신분당': EBColors.subway.sinbundang,
    '경의중앙선': EBColors.subway.gyongijungang,
    '경춘선': EBColors.subway.gyongchun,
    '수인분당': EBColors.subway.suinbundang,
    '공항': EBColors.subway.gonghang,
    '신림선': EBColors.subway.sillim,
    '의정부': EBColors.subway.uijongbu,
    '에버라인': EBColors.subway.everline,
    'GTX-A': EBColors.subway.gtx_a,
    '경강선': EBColors.subway.gyonggang,
    '우이신설': EBColors.subway.uisinsol,
    '서해선': EBColors.subway.sohae,
    '김포골드': EBColors.subway.gimpokkoldeu,
  };
}

extension on FindRouteBloc {
  void _onFetchFindRouteData(
    FetchFindRouteData event,
    Emitter<FindRouteState> emit,
  ) async {
    try {
      final ebRoute = await _findRouteRepository.getEBRoute();
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
      try {
        final subwayName = ebSubPath.transports?[0].subwayName;
        name = subwayName;
        color = _subwayColor[name];
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
