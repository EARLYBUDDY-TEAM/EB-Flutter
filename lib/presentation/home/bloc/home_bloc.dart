import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EBAuthRepository _authRepository;

  HomeBloc({
    required EBAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const HomeState()) {
    on<HomeAddSchedulePressed>(onHomeAddSchedulePressed);
    on<HomeMenuPressed>(onHomeMenuPressed);
  }

  void onHomeAddSchedulePressed(
    HomeAddSchedulePressed event,
    Emitter<HomeState> emit,
  ) {}

  void onHomeMenuPressed(
    HomeMenuPressed event,
    Emitter<HomeState> emit,
  ) {
    _authRepository.logOut();
  }
}
