import 'dart:async';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';

part 'event.dart';
part 'state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  final EBAuthRepository _authRepository;
  late StreamSubscription<EBAuthInfo> _authStatusSubscription;

  RootBloc({
    required EBAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const RootState.unAuth()) {
    on<ChangeEBAuthStatus>(_onChangeEBAuthStatus);
    on<RequestLogout>(_onRequestLogout);
    _authStatusSubscription = _authRepository.authInfo
        .listen((authInfo) => add(ChangeEBAuthStatus(authInfo)));
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}

extension on RootBloc {
  Future<void> _onChangeEBAuthStatus(
    ChangeEBAuthStatus event,
    Emitter<RootState> emit,
  ) async {
    switch (event.ebAuthInfo.status) {
      case EBAuthStatus.unauthenticated:
        return emit(const RootState.unAuth());
      case EBAuthStatus.authenticated:
        return emit(
          RootState(
            status: event.ebAuthInfo.status,
            token: event.ebAuthInfo.token,
          ),
        );
    }
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
