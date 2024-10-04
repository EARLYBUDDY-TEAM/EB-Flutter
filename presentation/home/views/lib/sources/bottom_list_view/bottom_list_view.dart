part of '../../eb_home.dart';

final class HomeBottomListView extends StatelessWidget {
  final double horizontalPadding;
  const HomeBottomListView({
    super.key,
    this.horizontalPadding = 20,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, List<ScheduleCard>>(
      selector: (state) => state.scheduleCardList,
      builder: (context, items) {
        return HomeBottomListStateful(
            horizontalPadding: horizontalPadding, items: items);
      },
    );
  }
}

final class HomeBottomListStateful extends StatefulWidget {
  final double horizontalPadding;
  final List<ScheduleCard> items;

  const HomeBottomListStateful({
    super.key,
    required this.items,
    required this.horizontalPadding,
  });

  @override
  State<StatefulWidget> createState() => HomeBottomListState();
}

final class HomeBottomListState extends State<HomeBottomListStateful> {
  @override
  Widget build(BuildContext context) {
    final bottomPadding = ScreenSize.safeArea.bottom(context);
    return ListView.separated(
      padding: EdgeInsets.only(
        top: 0,
        bottom: bottomPadding,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
      itemBuilder: (contex, index) {
        final item = widget.items[index];
        return Dismissible(
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
                    width: widget.horizontalPadding +
                        (widget.horizontalPadding / 2),
                  )
                ],
              )),
          // background: const Text("삭제"),
          child: BottomScheduleCardView(
            scheduleCard: item,
          ),
        );
      },
    );
  }
}
