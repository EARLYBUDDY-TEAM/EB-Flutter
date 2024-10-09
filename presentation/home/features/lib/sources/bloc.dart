part of '../eb_home_feature.dart';

final class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadingDelegate _loadingDelegate;
  final HomeRepositoryAB _homeRepository;
  final TokenEvent _tokenEvent;

  late StreamSubscription<BaseStatus> _loginStatusSubscription;
  late StreamSubscription<BaseStatus> _registerStatusSubscription;

  HomeBloc({
    required LoadingDelegate loadingDelegate,
    required HomeDelegate homeDelegate,
    required HomeRepositoryAB homeRepository,
    required TokenEvent tokenEvent,
  })  : _loadingDelegate = loadingDelegate,
        _homeRepository = homeRepository,
        _tokenEvent = tokenEvent,
        super(HomeState()) {
    on<SetHomeStatus>(_onSetHomeStatus);
    on<OnAppearHomeView>(_onOnAppearHomeView);
    on<InitHomeState>(_onInitHomeState);
    on<DeleteScheduleCard>(_onDeleteScheduleCard);

    _loginStatusSubscription = homeDelegate.loginStatus.listen(
      (status) => add(SetHomeStatus(login: status)),
    );

    _registerStatusSubscription = homeDelegate.registerStatus.listen(
      (status) => add(SetHomeStatus(register: status)),
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
  void _onSetHomeStatus(
    SetHomeStatus event,
    Emitter<HomeState> emit,
  ) {
    final homeStatus = state.status.copyWith(
      login: event.login,
      register: event.register,
      getAllScheduleCard: event.getAllScheduleCard,
      deleteScheduleCard: event.deleteScheduleCard,
    );

    emit(state.copyWith(status: homeStatus));
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

        final homeStatus =
            state.status.copyWith(getAllScheduleCard: BaseStatus.init);

        emit(
          state.copyWith(
            status: homeStatus,
            scheduleCardList: scheduleCardList,
          ),
        );
      case Failure():
        _tokenEvent.failureAction(
          result: getAllScheduleCardsResult,
          withAction: () {
            final homeStatus =
                state.status.copyWith(getAllScheduleCard: BaseStatus.fail);
            emit(state.copyWith(status: homeStatus));
          },
        );
    }
  }
}

extension on HomeBloc {
  Future<void> _onInitHomeState(
    InitHomeState event,
    Emitter<HomeState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    emit(event.homeState);
  }
}

extension on HomeBloc {
  Future<void> _onDeleteScheduleCard(
    DeleteScheduleCard event,
    Emitter<HomeState> emit,
  ) async {
    _loadingDelegate.set();

    Future<Result> deleteScheduleCardEvent(String accessToken) async {
      return await _homeRepository.deleteScheduleCard(
        accessToken: accessToken,
        scheduleID: event.scheduleID,
      );
    }

    final Result deleteScheduleCardResult =
        await _tokenEvent.checkExpired(withEvent: deleteScheduleCardEvent);

    _loadingDelegate.dismiss();

    switch (deleteScheduleCardResult) {
      case Success():
        final homeStatus =
            state.status.copyWith(deleteScheduleCard: BaseStatus.success);
        emit(state.copyWith(status: homeStatus));
        return;
      case Failure():
        _tokenEvent.failureAction(
          result: deleteScheduleCardResult,
          withAction: () {
            final homeStatus =
                state.status.copyWith(deleteScheduleCard: BaseStatus.fail);
            emit(state.copyWith(status: homeStatus));
          },
        );
    }
  }
}
