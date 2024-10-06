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
        return HomeBottomListContent(
          horizontalPadding: horizontalPadding,
          items: items,
        );
      },
    );
  }
}

final class HomeBottomListContent extends StatefulWidget {
  final double horizontalPadding;
  final List<ScheduleCard> items;

  const HomeBottomListContent({
    super.key,
    required this.items,
    required this.horizontalPadding,
  });

  @override
  State<StatefulWidget> createState() => HomeBottomListState();
}

final class HomeBottomListState extends State<HomeBottomListContent> {
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
        return SizedBox(height: widget.horizontalPadding);
      },
      itemBuilder: (contex, index) {
        final item = widget.items[index];
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _onDismissed(
              context: contex,
              direction: direction,
              scheduleID: item.scheduleID,
            );
          },
          background: _swipeDelete(),
          child: BottomScheduleCardView(scheduleCard: item),
        );
      },
    );
  }

  void _onDismissed({
    required BuildContext context,
    required DismissDirection direction,
    required int scheduleID,
  }) {
    if (direction != DismissDirection.endToStart) {
      return;
    }
    context.read<HomeBloc>().add(DeleteScheduleCard(scheduleID: scheduleID));
  }

  Widget _swipeDelete() {
    return Container(
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
            width: widget.horizontalPadding + (widget.horizontalPadding / 2),
          )
        ],
      ),
    );
  }
}
