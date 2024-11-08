part of '../../middle_transport_feature.dart';

final class MiddleTransportState extends Equatable {
  final MiddleTransportViewState viewState;

  MiddleTransportState({
    MiddleTransportViewState? viewState,
  }) : viewState = viewState ?? AddScheduleMiddleTransportState();

  MiddleTransportState copyWith({
    MiddleTransportViewState? viewState,
  }) =>
      MiddleTransportState(
        viewState: viewState ?? this.viewState,
      );

  @override
  List<Object?> get props => [
        viewState,
      ];
}
