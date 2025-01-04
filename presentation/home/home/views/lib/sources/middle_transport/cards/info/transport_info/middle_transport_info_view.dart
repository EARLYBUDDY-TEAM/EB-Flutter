part of '../../../../../eb_home.dart';

final class MiddleTransportInfoView extends StatelessWidget {
  final int currentIndex;
  final List<InfoMiddleTransportCardState> cardStateList;
  final StreamRealTimeInfo? streamRealTimeInfo;
  final double horizontalPadding;

  late SnapCardScrollController controller;

  MiddleTransportInfoView({
    super.key,
    required this.currentIndex,
    required this.cardStateList,
    required this.streamRealTimeInfo,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MiddleTranportBloc, MiddleTransportState>(
      buildWhen: _onTapImminentCard,
      builder: (context, state) {
        final cardCount = cardStateList.length + 1;
        final screenWidth = ScreenSize.width(context);
        const cardSpacing = 3;
        final cardRest = horizontalPadding - cardSpacing;
        controller = SnapCardScrollController.initWithScreenWidth(
          cardCount: cardCount,
          screenWidth: screenWidth,
          cardSpacing: 3,
          cardRest: cardRest,
          onChangeIndex: (index) => _onChangeIndex(
            context: context,
            index: index,
          ),
        );
        return SnapCardView(
          controller: controller,
          itemBuilder: _itemBuilder,
        );
      },
    );
  }

  bool Function(MiddleTransportState, MiddleTransportState)?
      get _onTapImminentCard {
    return (previous, current) {
      final curViewState = current.viewState;
      final preViewState = previous.viewState;

      if (curViewState is InfoMiddleTransportViewState) {
        if (preViewState is! InfoMiddleTransportViewState) {
          controller.moveTo(index: 0);
          return false;
        }
        if (preViewState.onTapImminentCard != curViewState.onTapImminentCard) {
          controller.moveTo(index: 0);
          return false;
        }
      }

      return false;
    };
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

      return MiddleTransportInfoCard(
        myIndex: index,
        cardWidth: cardWidth,
        cardState: cardState,
        streamBusRealTimeInfo: newStreamRealTimeInfo,
      );
    };
  }
}
