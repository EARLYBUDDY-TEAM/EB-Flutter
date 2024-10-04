part of '../eb_home_feature.dart';

final class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadingDelegate _loadingDelegate;
  final HomeRepository _homeRepository;
  final TokenEvent _tokenEvent;

  late StreamSubscription<BaseStatus> _loginStatusSubscription;
  late StreamSubscription<BaseStatus> _registerStatusSubscription;

  HomeBloc({
    required LoadingDelegate loadingDelegate,
    required HomeDelegate homeDelegate,
    required HomeRepository homeRepository,
    required TokenEvent tokenEvent,
  })  : _loadingDelegate = loadingDelegate,
        _homeRepository = homeRepository,
        _tokenEvent = tokenEvent,
        super(HomeState()) {
    on<PressAddScheduleButton>(_onPressAddScheduleButton);
    on<PressMenuButton>(_onPressMenuButton);
    on<SetLoginStatus>(_onSetLoginStatus);
    on<SetRegisterStatus>(_onSetRegisterStatus);
    on<OnAppearHomeView>(_onOnAppearHomeView);
    on<InitHomeState>(_oninitHomeState);
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

extension on HomeBloc {
  Future<void> _onOnAppearHomeView(
    OnAppearHomeView event,
    Emitter<HomeState> emit,
  ) async {
    _loadingDelegate.set();

    getAllScheduleCardsEvent(String accessToken) async {
      return await _homeRepository.getAllScheduleCards(
        accessToken: accessToken,
      );
    }

    final Result getAllScheduleCardsResult =
        await _tokenEvent.checkExpired(withEvent: getAllScheduleCardsEvent);

    _loadingDelegate.dismiss();

    switch (getAllScheduleCardsResult) {
      case Success():
        final List<ScheduleCard> scheduleCardList =
            getAllScheduleCardsResult.success.model;

        log(scheduleCardList.toString());
        emit(
          state.copyWith(
            scheduleCardStatus: BaseStatus.init,
            scheduleCardList: scheduleCardList,
          ),
        );
      case Failure():
        if (getAllScheduleCardsResult.failure is FailureResponse) {
          if (getAllScheduleCardsResult.failure.statusCode != 490) {
            emit(state.copyWith(scheduleCardStatus: BaseStatus.fail));
          }
        }
    }
  }
}

extension on HomeBloc {
  Future<void> _oninitHomeState(
    InitHomeState event,
    Emitter<HomeState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    emit(event.homeState);
  }
}
