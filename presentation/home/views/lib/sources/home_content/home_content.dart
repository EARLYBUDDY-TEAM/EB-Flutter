part of '../../eb_home.dart';

final class _HomeContent extends StatelessWidget {
  final double scheduleAddButtonSize = 60;
  final double spacing = 20;
  final double horizontalPadding = 20;

  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final bottomSafe = ScreenSize.safeArea.bottom(context);
    final bottomPadding = bottomSafe + scheduleAddButtonSize + spacing;

    return Column(
      children: [
        _addHorizontalPadding(_TopScheduleInfoView()),
        _MiddleTransportView(
          horizontalPadding: horizontalPadding,
        ),
        _addHorizontalPadding(const HomeCalendar()),
        SizedBox(height: spacing),
        _addHorizontalPadding(const HomeBottomListView()),
        SizedBox(height: bottomPadding),
      ],
    );
  }

  Widget _addHorizontalPadding(Widget content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: content,
    );
  }
}
