part of '../../../../../eb_home.dart';

final class MiddleTransportInfoView extends StatelessWidget {
  final int currentIndex;
  final List<InfoMiddleTransportCardState> cardStateList;
  final Stream<RealTimeInfo?> streamRealTimeInfo;
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
      cardCount: cardStateList.length,
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

  Widget? Function(BuildContext, int) _itemBuilder(
      {required double cardWidth}) {
    return (context, index) {
      final newStreamRealTimeInfo =
          (currentIndex == index) ? streamRealTimeInfo : null;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
          width: cardWidth,
          child: _MiddleTransportInfoCardStatefulView(
            index: index,
            cardState: cardStateList[index],
            streamRealTimeInfo: newStreamRealTimeInfo,
          ),
        ),
      );
    };
  }
}
