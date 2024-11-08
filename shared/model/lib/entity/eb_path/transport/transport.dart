part of '../../../entity.dart';

sealed class Transport extends Equatable {}

sealed class TransportList extends Equatable {
  static TransportList mockSubwayList() {
    return SubwayList(
      subwayList: [
        Subway.mock(),
      ],
    );
  }

  static TransportList mockBusList() {
    return BusList(
      busList: [
        Bus.mock(),
        Bus.mock(),
        Bus.mock(),
        Bus.mock(),
        Bus.mock(),
        Bus.mock(),
      ],
    );
  }

  Transport? get firstOrNull {
    final self = this;
    switch (self) {
      case SubwayList():
        return self.subwayList.firstOrNull;
      case BusList():
        return self.busList.firstOrNull;
      default:
        return null;
    }
  }
}

final class EmptyTransportList extends TransportList {
  @override
  List<Object?> get props => [];
}
