part of '../../eb_home.dart';

final class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const _TopScheduleInfoView(),
          const SizedBox(height: 30),
          const _MiddleTransportInfoView(),
          const SizedBox(height: 30),
          _HomeCalendar(),
          const SizedBox(height: 30),
          const HomeBottomListView(),
        ],
      ),
    );
  }
}