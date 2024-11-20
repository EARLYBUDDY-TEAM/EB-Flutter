part of '../../detailroute_feature.dart';

final class DetailRouteState extends Equatable {
  final Transport? selectedTransport;

  const DetailRouteState({
    required this.selectedTransport,
  });

  DetailRouteState copyWith({
    Transport? Function()? selectedTransport,
  }) {
    return DetailRouteState(
      selectedTransport: selectedTransport != null ? selectedTransport() : null,
    );
  }

  @override
  List<Object?> get props => [selectedTransport];
}
