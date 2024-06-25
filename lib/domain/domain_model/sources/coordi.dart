part of 'domain_model.dart';

final class Coordi extends Equatable {
  final String x;
  final String y;

  const Coordi({
    required this.x,
    required this.y,
  });

  Coordi.fromDTO({
    required CoordiDTO coordiDTO,
  })  : x = coordiDTO.x,
        y = coordiDTO.y;

  @override
  List<Object?> get props => [x, y];
}