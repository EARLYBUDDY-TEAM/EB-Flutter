import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final EBAuthRepository _authRepository;
  late StreamSubscription<EBAuthInfo> _authStatusSubscription;

  AuthBloc({
    required EBAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState.unAuth()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    _authStatusSubscription = _authRepository.authInfo
        .listen((authInfo) => add(AuthStatusChanged(authInfo)));
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}

extension on AuthBloc {
  Future<void> _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.authInfo.status) {
      case EBAuthStatus.unauthenticated:
        return emit(const AuthState.unAuth());
      case EBAuthStatus.authenticated:
        return emit(
          AuthState(
            status: event.authInfo.status,
            token: event.authInfo.token,
          ),
        );
    }
  }
}

extension on AuthBloc {
  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    _authRepository.logOut();
  }
}
