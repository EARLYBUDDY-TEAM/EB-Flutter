part of '../eb_home_feature.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late StreamSubscription<BaseStatus> _loginStatusSubscription;
  late StreamSubscription<BaseStatus> _registerStatusSubscription;

  HomeBloc({
    required HomeDelegate homeDelegate,
  }) : super(const HomeState()) {
    on<PressAddScheduleButton>(_onPressAddScheduleButton);
    on<PressMenuButton>(_onPressMenuButton);
    on<SetLoginStatus>(_onSetLoginStatus);
    on<SetRegisterStatus>(_onSetRegisterStatus);
    _loginStatusSubscription = homeDelegate.loginStatus.listen(
      (status) => add(SetLoginStatus(status: status)),
    );
    _registerStatusSubscription = homeDelegate.registerStatus.listen(
      (status) => add(SetRegisterStatus(status: status)),
    );
  }

  @override
  Future<void> close() {
    _loginStatusSubscription.cancel();
    _registerStatusSubscription.cancel();
    return super.close();
  }
}

extension on HomeBloc {
  void _onPressAddScheduleButton(
    PressAddScheduleButton event,
    Emitter<HomeState> emit,
  ) {}
}

extension on HomeBloc {
  void _onPressMenuButton(
    PressMenuButton event,
    Emitter<HomeState> emit,
  ) {
    // _authRepository.logOut();
  }
}

extension on HomeBloc {
  void _onSetLoginStatus(
    SetLoginStatus event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(loginStatus: event.status));
  }

  void _onSetRegisterStatus(
    SetRegisterStatus event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(registerStatus: event.status));
  }
}
