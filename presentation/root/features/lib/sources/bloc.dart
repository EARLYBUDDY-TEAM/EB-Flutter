part of '../eb_root_feature.dart';

final class RootBloc extends Bloc<RootEvent, RootState> {
  late StreamSubscription<AuthStatus> _authStatusSubscription;

  RootBloc({
    required RootDelegate rootDelegate,
  }) : super(RootState()) {
    on<ChangeAuthStatus>(_onChangeAuthStatus);
    _authStatusSubscription = rootDelegate.authStatus
        .listen((authInfo) => add(ChangeAuthStatus(authInfo)));
  }

  @override
  Future<void> close() async {
    await _authStatusSubscription.cancel();
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
