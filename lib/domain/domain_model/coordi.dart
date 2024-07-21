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

  static Coordi mockStart() {
    return const Coordi(
      x: '127.10297988971773',
      y: '37.48800665367514',
    );
  }

  static Coordi mockEnd() {
    return const Coordi(
      x: '126.994596',
      y: '37.534542',
    );
  }
}
