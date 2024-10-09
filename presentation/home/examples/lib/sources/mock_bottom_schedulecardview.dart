part of 'home_example.dart';

final class MockBottomScheduleCardExample extends StatelessWidget {
  const MockBottomScheduleCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: EBTheme.light(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: _MockBottomScheduleCardListView(),
        ),
      ),
    );
  }
}

final longTextCard = ScheduleCard(
  scheduleID: 10,
  title: "MockTitle" * 20,
  time: DateTime.now(),
  endPlaceName: "mockEndPlaceName" * 20,
);

final class _MockBottomScheduleCardListView extends StatelessWidget {
  final items = List<ScheduleCard>.generate(20, (i) {
    bool flag = (i + 1) % 2 == 0 ? true : false;
    return flag ? longTextCard : ScheduleCard.mockwithPlace();
  });
  final double horizontalPadding = 20;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: horizontalPadding,
      ),
      child: HomeBottomListContent(
        horizontalPadding: horizontalPadding,
        items: items,
      ),
    );
  }
}
