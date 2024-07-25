part of 'bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeAddSchedulePressed extends HomeEvent {
  const HomeAddSchedulePressed();
}

final class HomeMenuPressed extends HomeEvent {
  const HomeMenuPressed();
}
