part of '../../../home_feature.dart';

final class MiddleTransportInfoState extends Equatable {
  final SchedulePath? todayCloseSchedulePath;

  const MiddleTransportInfoState({
    this.todayCloseSchedulePath,
  });

  @override
  List<Object?> get props => [todayCloseSchedulePath];
}
