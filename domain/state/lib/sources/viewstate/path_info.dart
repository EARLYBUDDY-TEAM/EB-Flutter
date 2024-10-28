part of '../../eb_state.dart';

final class PathInfo extends Equatable {
  final Place startPlace;
  final Place endPlace;
  final TransportLineOfPath transportLineOfPath;
  final EBPath ebPath;

  const PathInfo({
    required this.startPlace,
    required this.endPlace,
    required this.transportLineOfPath,
    required this.ebPath,
  });

  PathInfo copyWith({
    Place? startPlace,
    Place? endPlace,
    TransportLineOfPath? transportLineOfPath,
    EBPath? ebPath,
  }) {
    return PathInfo(
      startPlace: startPlace ?? this.startPlace,
      endPlace: endPlace ?? this.endPlace,
      transportLineOfPath: transportLineOfPath ?? this.transportLineOfPath,
      ebPath: ebPath ?? this.ebPath,
    );
  }

  @override
  List<Object?> get props => [
        startPlace,
        endPlace,
        transportLineOfPath,
        ebPath,
      ];
}
