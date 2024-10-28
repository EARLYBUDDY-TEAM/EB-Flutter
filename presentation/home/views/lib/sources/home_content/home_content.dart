part of '../../eb_home.dart';

final class _HomeContent extends StatelessWidget {
  final double scheduleAddButtonSize = 60;
  final double spacing = 30;

  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final bottomSafe = ScreenSize.safeArea.bottom(context);
    final bottomPadding = bottomSafe + scheduleAddButtonSize + spacing;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _TopScheduleInfoView(),
          SizedBox(height: spacing),
          const _MiddleTransportInfoView(),
          SizedBox(height: spacing),
          const HomeCalendar(),
          SizedBox(height: spacing),
          const HomeBottomListView(),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
