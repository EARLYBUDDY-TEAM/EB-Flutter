part of '../../eb_home_feature.dart';

final class HomeState extends Equatable {
  final HomeStatus status;
  final BottomScheduleListState bottomScheduleListState;

  HomeState({
    HomeStatus? status,
    BottomScheduleListState? bottomScheduleListState,
  })  : status = status ?? const HomeStatus(),
        bottomScheduleListState =
            bottomScheduleListState ?? BottomScheduleListState();

  @override
  List<Object?> get props => [
        status,
        bottomScheduleListState,
      ];

  HomeState copyWith({
    HomeStatus? status,
    BottomScheduleListState? bottomScheduleListState,
  }) =>
      HomeState(
        status: status ?? this.status,
        bottomScheduleListState:
            bottomScheduleListState ?? this.bottomScheduleListState,
      );
}
