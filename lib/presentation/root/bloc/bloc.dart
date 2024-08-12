import 'dart:async';
import 'package:earlybuddy/domain/repository/repository.dart';
import 'package:earlybuddy/shared/eb_model/entity/entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

final class RootBloc extends Bloc<RootEvent, RootState> {
  final EBAuthRepository _authRepository;
  late StreamSubscription<AuthStatus> _authStatusSubscription;

  RootBloc({
    required EBAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(RootState()) {
    on<ChangeAuthStatus>(_onChangeAuthStatus);
    on<RequestLogout>(_onRequestLogout);
    _authStatusSubscription = _authRepository.authInfo
        .listen((authInfo) => add(ChangeAuthStatus(authInfo)));
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}

extension on RootBloc {
  Future<void> _onChangeAuthStatus(
    ChangeAuthStatus event,
    Emitter<RootState> emit,
  ) async {
    emit(state.copyWith(status: event.status));
  }
}

extension on RootBloc {
  Future<void> _onRequestLogout(
    RequestLogout event,
    Emitter<RootState> emit,
  ) async {
    _authRepository.logOut();
  }
}