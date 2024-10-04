part of '../../eb_home.dart';

final class HomeBottomListView extends StatefulWidget {
  final List<ScheduleCard> items;

  const HomeBottomListView({
    super.key,
    required this.items,
  });

  @override
  State<StatefulWidget> createState() => HomeBottomListState();
}

final class HomeBottomListState extends State<HomeBottomListView> {
  final double horizontalPadding = 20;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
      itemBuilder: (contex, index) {
        final item = widget.items[index];
        return Dismissible(
          // key: Key(item.scheduleID.toString()),
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            setState(() {
              widget.items.removeAt(index);
            });

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('MockCard $index dismissed')));
          },
          background: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "삭제",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontFamily.nanumSquareExtraBold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: horizontalPadding + (horizontalPadding / 2),
                  )
                ],
              )),
          // background: const Text("삭제"),
          child: _bottomScheduleCardView(item),
        );
      },
    );
  }

  Widget _bottomScheduleCardView(ScheduleCard scheduleCard) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: BottomScheduleCardView(
        scheduleCard: scheduleCard,
      ),
    );
  }
}
