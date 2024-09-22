part of '../eb_home_feature.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EBAuthRepository _authRepository;
  final RegisterDelegate _registerDelegate;
  final LoginDelegate _loginDelegate;

  late StreamSubscription<BaseStatus> _loginStatusSubscription;

  HomeBloc({
    required EBAuthRepository authRepository,
    required RegisterDelegate registerDelegate,
    required LoginDelegate loginDelegate,
    required HomeDelegate homeDelegate,
  })  : _authRepository = authRepository,
        _registerDelegate = registerDelegate,
        _loginDelegate = loginDelegate,
        super(const HomeState()) {
    on<PressAddScheduleButton>(_onPressAddScheduleButton);
    on<PressMenuButton>(_onPressMenuButton);
    on<PressRegisterAlertOkButton>(_onPressRegisterAlertOkButton);
    on<DismissLoginSnackbar>(_onDismissLoginSnackbar);
    on<SetLoginStatus>(_onSetLoginStatus);
    _loginStatusSubscription = homeDelegate.loginStatus.listen(
      (status) => add(SetLoginStatus(status: status)),
    );
  }

  @override
  Future<void> close() {
    _loginStatusSubscription.cancel();
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
    _authRepository.logOut();
  }
}

extension on HomeBloc {
  void _onPressRegisterAlertOkButton(
    PressRegisterAlertOkButton event,
    Emitter<HomeState> emit,
  ) {
    _registerDelegate.clearFirstLogin();
  }
}

extension on HomeBloc {
  void _onDismissLoginSnackbar(
    DismissLoginSnackbar event,
    Emitter<HomeState> emit,
  ) {
    _loginDelegate.clearIsSuccess();
  }
}

extension on HomeBloc {
  void _onSetLoginStatus(
    SetLoginStatus event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(loginStatus: event.status));
  }
}
