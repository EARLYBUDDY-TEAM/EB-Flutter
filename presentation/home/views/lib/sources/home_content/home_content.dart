part of '../../eb_home.dart';

final class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _TopScheduleInfoView(),
          SizedBox(height: 30),
          _MiddleTransportInfoView(),
          SizedBox(height: 30),
          HomeCalendar(),
          SizedBox(height: 30),
          HomeBottomListView(),
        ],
      ),
    );
  }
}
