import 'dart:developer';

import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/repository/findroute/findroute_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'findroute_event.dart';
part 'findroute_state.dart';

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

extension on FindRouteBloc {
  void _onFetchFindRouteData(
    FetchFindRouteData event,
    Emitter<FindRouteState> emit,
  ) async {
    try {
      final ebRoute = await _findRouteRepository.getEBRoute();
      emit(
        state.copyWith(ebRoute: ebRoute),
      );
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(ebRoute: null),
      );
    }
  }
}
