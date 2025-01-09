part of '../../../../../eb_home.dart';

final class MiddleTransportImminentCard extends StatelessWidget {
  const MiddleTransportImminentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MiddleTranportBloc, MiddleTransportState,
        ImminentState>(
      selector: (state) {
        final viewState = state.viewState;
        if (viewState is InfoMiddleTransportViewState) {
          return viewState.imminentCardState.imminentState;
        }
        return ImminentState.notImminent;
      },
      builder: (context, imminentState) {
        final title = _getTitle(imminentState);

        return MiddleTransportCardForm(
          horizontalPadding: 10,
          verticalPadding: 10,
          child: _MiddleTransportImminentCardContent(
            title: title,
            onTap: () {
              context
                  .read<MiddleTranportBloc>()
                  .add(OnTapMiddleTransportImminentCard());
            },
          ),
        );
      },
    );
  }

  String _getTitle(ImminentState imminentState) {
    switch (imminentState) {
      case ImminentState.notImminent:
        return '일정이 다가오고 있어요';
      case ImminentState.imminent:
        return '곧 도착이에요! 즐거운 시간 되세요 😀';
      case ImminentState.overSchedule:
        return '늦지 않게 출발하셨나요?';
    }
  }
}

final class _MiddleTransportImminentCardContent extends StatelessWidget {
  final String title;
  final Function() onTap;

  const _MiddleTransportImminentCardContent({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: FontFamily.gmarketSansBold,
                fontSize: 18,
                color: EBColors.blue3,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "아직 출발 전이에요 >",
              style: TextStyle(
                fontFamily: FontFamily.gmarketSansRegular,
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
