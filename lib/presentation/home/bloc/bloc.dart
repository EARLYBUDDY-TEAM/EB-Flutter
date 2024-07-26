import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EBAuthRepository _authRepository;

  HomeBloc({
    required EBAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const HomeState()) {
    on<PressAddScheduleButton>(_onPressAddScheduleButton);
    on<PressMenuButton>(_onPressMenuButton);
  }

  void _onPressAddScheduleButton(
    PressAddScheduleButton event,
    Emitter<HomeState> emit,
  ) {}

  void _onPressMenuButton(
    PressMenuButton event,
    Emitter<HomeState> emit,
  ) {
    _authRepository.logOut();
  }
}
