part of '../../middle_transport_feature.dart';

final class MiddleTransportState extends Equatable {
  final SealedMiddleTransportViewState viewState;

  MiddleTransportState({
    SealedMiddleTransportViewState? viewState,
  }) : viewState = viewState ?? AddScheduleMiddleTransportState();

  MiddleTransportState copyWith({
    SealedMiddleTransportViewState? viewState,
  }) =>
      MiddleTransportState(
        viewState: viewState ?? this.viewState,
      );

  @override
  List<Object?> get props => [
        viewState,
      ];
}
