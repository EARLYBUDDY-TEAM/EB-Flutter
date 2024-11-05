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
      ],
    );
  }
}

final class EmptyTransportList extends TransportList {
  @override
  List<Object?> get props => [];
}
