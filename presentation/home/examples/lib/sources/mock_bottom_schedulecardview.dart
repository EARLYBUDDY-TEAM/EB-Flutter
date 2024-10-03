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

final class _MockBottomScheduleCardListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MockBottomScheduleCardListState();
}

final class _MockBottomScheduleCardListState
    extends State<_MockBottomScheduleCardListView> {
  final items = List<ScheduleCard>.generate(20, (i) {
    bool flag = (i + 1) % 2 == 0 ? true : false;
    return flag ? ScheduleCard.mock() : ScheduleCard.mockwithPlace();
  });

  _MockBottomScheduleCardListState();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
      itemBuilder: (contex, index) {
        final item = items[index];
        return Dismissible(
          // key: Key(item.scheduleID.toString()),
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              items.removeAt(index);
            });

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('MockCard $index dismissed')));
          },
          background: Container(color: Colors.red),
          child: _bottomScheduleCardView(item),
        );
      },
    );
  }

  Widget _bottomScheduleCardView(ScheduleCard scheduleCard) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BottomScheduleCardView(
        scheduleCard: scheduleCard,
      ),
    );
  }
}
