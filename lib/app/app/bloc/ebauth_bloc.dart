import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';

part 'ebauth_event.dart';
part 'ebauth_state.dart';

class EBAuthBloc extends Bloc<EBAuthEvent, EBAuthState> {
  final EBAuthRepository _authRepository;
  late StreamSubscription<EBAuthInfo> _authStatusSubscription;

  EBAuthBloc({
    required EBAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const EBAuthState.unAuth()) {
    on<EBAuthStatusChanged>(_onAuthStatusChanged);
    on<EBAuthLogoutRequested>(_onAuthLogoutRequested);
    _authStatusSubscription = _authRepository.authInfo
        .listen((authInfo) => add(EBAuthStatusChanged(authInfo)));
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}

extension on EBAuthBloc {
  Future<void> _onAuthStatusChanged(
    EBAuthStatusChanged event,
    Emitter<EBAuthState> emit,
  ) async {
    switch (event.ebAuthInfo.status) {
      case EBAuthStatus.unauthenticated:
        return emit(const EBAuthState.unAuth());
      case EBAuthStatus.authenticated:
        return emit(
          EBAuthState(
            status: event.ebAuthInfo.status,
            token: event.ebAuthInfo.token,
          ),
        );
    }
  }
}

extension on EBAuthBloc {
  Future<void> _onAuthLogoutRequested(
    EBAuthLogoutRequested event,
    Emitter<EBAuthState> emit,
  ) async {
    _authRepository.logOut();
  }
}
