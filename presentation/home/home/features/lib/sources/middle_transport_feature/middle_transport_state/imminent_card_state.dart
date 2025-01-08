part of '../../../middle_transport_feature.dart';

final class ImminentCardState extends Equatable {
  final bool onTapImminentCard;
  final bool isImminent;

  const ImminentCardState({
    this.onTapImminentCard = false,
    this.isImminent = false,
  });

  ImminentCardState copyWith({
    bool? onTapImminentCard,
    bool? isImminent,
  }) {
    return ImminentCardState(
      onTapImminentCard: onTapImminentCard ?? this.onTapImminentCard,
      isImminent: isImminent ?? this.isImminent,
    );
  }

  @override
  List<Object?> get props => [
        onTapImminentCard,
        isImminent,
      ];
}
