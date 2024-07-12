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
  final int pathTime;
  final List<TransportLineInfo> lineOfPath;

  const TransportLineOfPath({
    required this.lineOfPath,
    required this.pathTime,
  });

  @override
  List<Object?> get props => [lineOfPath];

  static TransportLineOfPath mock() {
    final walk1 = TransportLineInfo.walkMock();
    final subway1 = TransportLineInfo.subwayMock();
    final walk2 = TransportLineInfo.walkMock();
    final subway2 = TransportLineInfo.subwayMock();
    final bus1 = TransportLineInfo.busMock();
    final lineOfPath = [walk1, subway1, walk2, subway2, bus1];
    final int pathTime = lineOfPath.fold(0, (t, e) => t + e.time);

    return TransportLineOfPath(
      pathTime: pathTime,
      lineOfPath: lineOfPath,
    );
  }
}

class TransportLineInfo extends Equatable {
  final String? name;
  final int time;
  final Color? color;

  const TransportLineInfo({
    required this.name,
    required this.time,
    required this.color,
  });

  @override
  List<Object?> get props => [
        name,
        time,
        color,
      ];

  static TransportLineInfo subwayMock() {
    return const TransportLineInfo(
      name: '2호선',
      time: 35,
      color: Colors.green,
    );
  }

  static TransportLineInfo busMock() {
    return const TransportLineInfo(
      name: '406',
      time: 73,
      color: Colors.blue,
    );
  }

  static TransportLineInfo walkMock() {
    return const TransportLineInfo(
      name: null,
      time: 2,
      color: null,
    );
  }
}
