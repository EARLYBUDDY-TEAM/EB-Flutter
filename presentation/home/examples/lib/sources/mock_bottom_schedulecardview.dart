part of 'home_example.dart';

final class MockBottomScheduleCardExample extends StatelessWidget {
  const MockBottomScheduleCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: EBTheme.light(),
      home: Scaffold(
        body: Center(
          child: _MockBottomScheduleCardListView(),
        ),
      ),
    );
  }
}

final class _MockBottomScheduleCardListView extends StatelessWidget {
  final items = List<ScheduleCard>.generate(20, (i) {
    bool flag = (i + 1) % 2 == 0 ? true : false;
    return flag ? ScheduleCard.mock() : ScheduleCard.mockwithPlace();
  });

  _MockBottomScheduleCardListView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
      itemBuilder: (contex, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BottomScheduleCardView(
            scheduleCard: items[index],
          ),
        );
      },
    );
  }
}
