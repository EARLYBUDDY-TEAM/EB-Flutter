part of '../eb_detail_route_feature.dart';

final class DetailRouteState extends Equatable {
  final EBPath ebPath;

  const DetailRouteState({required this.ebPath});

  DetailRouteState copyWith({
    EBPath? ebPath,
  }) {
    return DetailRouteState(
      ebPath: ebPath ?? this.ebPath,
    );
  }

  @override
  List<Object?> get props => [ebPath];
}
