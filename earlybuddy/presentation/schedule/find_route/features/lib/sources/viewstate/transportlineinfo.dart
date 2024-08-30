part of '../../eb_find_route_feature.dart';

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
    final walk1 = TransportLineInfo.walkMock();
    final subway1 = TransportLineInfo.subwayMock();
    final walk2 = TransportLineInfo.walkMock();
    final subway2 = TransportLineInfo.subwayMock();
    final bus1 = TransportLineInfo.busMock();
    final lineOfPath = [walk1, subway1, walk2, subway2, bus1];

    return TransportLineOfPath(
      lineOfPath: lineOfPath,
    );
  }
}

class TransportLineInfo extends Equatable {
  final String name;
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
    final subway = Subway.mock();
    return TransportLineInfo(
      name: subway.type,
      time: 35,
      color: subway.color(),
    );
  }

  static TransportLineInfo busMock() {
    final bus = Bus.mock();
    return TransportLineInfo(
      name: bus.number,
      time: 73,
      color: bus.color(),
    );
  }

  static TransportLineInfo walkMock() {
    const int time = 2;
    return const TransportLineInfo(
      name: '${2}분',
      time: time,
      color: null,
    );
  }
}
