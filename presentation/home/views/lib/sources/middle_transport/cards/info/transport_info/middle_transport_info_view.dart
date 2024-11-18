part of '../../../../../eb_home.dart';

final class MiddleTransportInfoView extends StatelessWidget {
  final int currentIndex;
  final List<InfoMiddleTransportCardState> cardStateList;
  final StreamRealTimeInfo? streamRealTimeInfo;
  final double horizontalPadding;

  const MiddleTransportInfoView({
    super.key,
    required this.currentIndex,
    required this.cardStateList,
    required this.streamRealTimeInfo,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SnapCardView(
      cardCount: cardStateList.length + 1,
      listHorizontalPadding: horizontalPadding,
      cardSpacing: 3,
      initialIndex: currentIndex,
      onChangeIndex: (index) => _onChangeIndex(
        context: context,
        index: index,
      ),
      itemBuilder: _itemBuilder,
    );
  }

  void _onChangeIndex({
    required BuildContext context,
    required int index,
  }) {
    context.read<MiddleTranportBloc>().add(
          ChangeTransportInfoCard(expectIndex: index),
        );
  }

  Widget? Function(BuildContext, int) _itemBuilder({
    required double cardWidth,
  }) {
    return (context, index) {
      if (index == cardStateList.length) {
        return _MiddleTransportCardWithScale(
          cardWidth: cardWidth,
          scaleTrigger: (currentIndex == index),
          child: const MiddleTransportArrivalCard(),
        );
      }

      final newStreamRealTimeInfo =
          (currentIndex == index) ? streamRealTimeInfo : null;
      final cardState = cardStateList[index];

      return _MiddleTransportInfoCard(
        myIndex: index,
        cardWidth: cardWidth,
        cardState: cardState,
        streamBusRealTimeInfo: newStreamRealTimeInfo,
      );
    };
  }
}
