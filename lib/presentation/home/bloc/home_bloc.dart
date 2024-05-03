import 'package:earlybuddy/domain/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthRepository _authRepository;

  HomeBloc({
    required AuthRepository authRepository,
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
