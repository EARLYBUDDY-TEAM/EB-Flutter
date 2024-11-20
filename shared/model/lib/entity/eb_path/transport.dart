part of '../../entity.dart';

typedef TransportMap = Map<String, Transport>;

TransportMap createTransportMap(
  List<Transport> transportList,
) {
  Map<String, Transport> tmpTransportMap = {};
  switch (transportList) {
    case List<Subway>():
      tmpTransportMap = {for (var t in transportList) t.type: t};
    case List<Bus>():
      tmpTransportMap = {for (var t in transportList) t.number: t};
  }

  return tmpTransportMap;
}

sealed class Transport extends Equatable {
  TransportDTO toDTO() {
    throw UnimplementedError('구현부');
  }

  Color getColor() {
    final self = this;
    switch (self) {
      case Subway():
        return self.color();
      case Bus():
        return self.color();
    }
  }

  String getName() {
    final self = this;
    switch (self) {
      case Subway():
        return self.type;
      case Bus():
        return self.number;
    }
  }
}

final class Subway extends Transport {
  final String type;

  Subway({
    required this.type,
  });

  static Subway fromDTO({
    required TransportDTO transportDTO,
  }) {
    final type = transportDTO.subwayType ?? DefaultValue.String;
    return Subway(
      type: type,
    );
  }

  @override
  TransportDTO toDTO() {
    return TransportDTO(
      subwayType: type,
      busNumber: null,
      busType: null,
    );
  }

  Color color() {
    switch (type) {
      case '1호선':
        return EBColors.subway.line1;
      case '2호선':
        return EBColors.subway.line2;
      case '3호선':
        return EBColors.subway.line3;
      case '4호선':
        return EBColors.subway.line4;
      case '5호선':
        return EBColors.subway.line5;
      case '6호선':
        return EBColors.subway.line6;
      case '7호선':
        return EBColors.subway.line7;
      case '8호선':
        return EBColors.subway.line8;
      case '9호선':
        return EBColors.subway.line9;
      case '인천1호선':
        return EBColors.subway.incheon1;
      case '인천2호선':
        return EBColors.subway.incheon2;
      case 'GTX-A':
        return EBColors.subway.gtx_a;
      case '공항철도':
        return EBColors.subway.gonghang;
      case '자기부상철도':
        return EBColors.subway.jagibusang;
      case '경의중앙선':
        return EBColors.subway.gyongijungang;
      case '에버라인':
        return EBColors.subway.everline;
      case '경춘선':
        return EBColors.subway.gyongchun;
      case '신분당선':
        return EBColors.subway.sinbundang;
      case '의정부경전철':
        return EBColors.subway.uijongbu;
      case '경강선':
        return EBColors.subway.gyonggang;
      case '우이신설선':
        return EBColors.subway.uisinsol;
      case '서해선':
        return EBColors.subway.sohae;
      case '김포골드라인':
        return EBColors.subway.gimpogold;
      case '수인분당선':
        return EBColors.subway.suinbundang;
      case '신림선':
        return EBColors.subway.sillim;
      default:
        return EBColors.subway.line1;
    }
  }

  @override
  List<Object?> get props => [type];

  static Subway mock() {
    return Subway(type: '1호선');
  }
}

final class Bus extends Transport {
  final String number;
  final String type;

  Bus({
    required this.number,
    required this.type,
  });

  static Bus fromDTO({required TransportDTO transportDTO}) {
    final number = transportDTO.busNumber ?? DefaultValue.String;
    final type = transportDTO.busType ?? DefaultValue.String;
    return Bus(
      number: number,
      type: type,
    );
  }

  @override
  TransportDTO toDTO() {
    return TransportDTO(
      subwayType: null,
      busNumber: number,
      busType: type,
    );
  }

  Color color() {
    switch (type) {
      case '간선':
        return EBColors.bus.ganson;
      case '지선':
        return EBColors.bus.jison;
      case '광역':
        return EBColors.bus.gwangyok;
      default:
        return EBColors.bus.others;
    }
  }

  @override
  List<Object?> get props => [number, type];

  static Bus mock() {
    final random = Random();
    final int num = 100 + random.nextInt(999 - 100);
    return Bus(number: "$num", type: '지선');
  }
}
