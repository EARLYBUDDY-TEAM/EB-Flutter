part of '../../bloc.dart';

class TransportLineOfRoute extends Equatable {
  final List<TransportLineOfPath> lineOfRoute;

  const TransportLineOfRoute({
    this.lineOfRoute = const [],
  });

  @override
  List<Object?> get props => [lineOfRoute];
}

class TransportLineOfPath extends Equatable {
  final List<TransportLineInfo> lineOfPath;

  const TransportLineOfPath({
    required this.lineOfPath,
  });

  @override
  List<Object?> get props => [lineOfPath];

  static TransportLineOfPath mock() {
    return TransportLineOfPath(lineOfPath: [
      TransportLineInfo.mock(),
      TransportLineInfo.mock(),
      TransportLineInfo.mock(),
      TransportLineInfo.mock(),
    ]);
  }
}

class TransportLineInfo extends Equatable {
  final int type;
  final String? name;
  final int length;
  final Color? color;

  const TransportLineInfo({
    required this.type,
    required this.name,
    required this.length,
    required this.color,
  });

  @override
  List<Object?> get props => [
        type,
        name,
        length,
        color,
      ];

  static TransportLineInfo mock() {
    return const TransportLineInfo(
      type: 1,
      name: '2호선',
      length: 30,
      color: Colors.green,
    );
  }
}
