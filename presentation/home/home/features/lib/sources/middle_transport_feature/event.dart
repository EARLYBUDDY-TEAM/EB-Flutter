part of '../../middle_transport_feature.dart';

sealed class MiddleTransportEvent extends Equatable {}

final class SetupMiddleTransport extends MiddleTransportEvent {
  final SchedulePath? schedulePath;

  SetupMiddleTransport({
    required this.schedulePath,
  });

  @override
  List<Object?> get props => [schedulePath];
}

final class PressReloadButton extends MiddleTransportEvent {
  final int selectedIndex;

  PressReloadButton({
    required this.selectedIndex,
  });

  @override
  List<Object?> get props => [selectedIndex];
}

final class SelectTransport extends MiddleTransportEvent {
  final Transport selectedTransport;
  final int selectedIndex;

  SelectTransport({
    required this.selectedTransport,
    required this.selectedIndex,
  });

  @override
  List<Object?> get props => [
        selectedTransport,
        selectedIndex,
      ];
}

final class ChangeTransportInfoCard extends MiddleTransportEvent {
  final int expectIndex;

  ChangeTransportInfoCard({
    required this.expectIndex,
  });

  @override
  List<Object?> get props => [expectIndex];
}

final class OnTapMiddleTransportImminentCard extends MiddleTransportEvent {
  @override
  List<Object?> get props => [];
}
