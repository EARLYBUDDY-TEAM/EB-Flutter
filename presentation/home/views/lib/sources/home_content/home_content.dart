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
          _homeCalenDar(),
          const SizedBox(height: 30),
          const HomeBottomListView(),
        ],
      ),
    );
  }

  Widget _homeCalenDar() {
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [EBBoxShadow.init()]),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: HomeCalendar(),
        ),
      ),
    );
  }
}
