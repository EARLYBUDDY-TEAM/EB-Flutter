part of '../../eb_home.dart';

final class HomeBottomListView extends StatelessWidget {
  final double horizontalPadding;
  const HomeBottomListView({
    super.key,
    this.horizontalPadding = 20,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) {
        return previous.status.deleteScheduleCard !=
            current.status.deleteScheduleCard;
      },
      listener: (context, state) async {
        await _deleteScheduleCardErrorSnackBar(
          context,
          state.status.deleteScheduleCard,
        );
      },
      buildWhen: (previous, current) {
        return previous.scheduleCardList != current.scheduleCardList;
      },
      builder: (context, state) {
        return HomeBottomListContent(
          horizontalPadding: horizontalPadding,
          items: state.scheduleCardList,
        );
      },
    );
  }

  Future<void> _deleteScheduleCardErrorSnackBar(
    BuildContext context,
    BaseStatus deleteScheduleCard,
  ) async {
    if (deleteScheduleCard != BaseStatus.success) {
      return;
    }

    await Future<void>.delayed(const Duration(seconds: 1));

    final snackBar = EBSnackBar(text: '스케줄을 삭제했습니다.');
    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((_) {
      context
          .read<HomeBloc>()
          .add(const SetHomeStatus(deleteScheduleCard: BaseStatus.init));
    });
  }
}

final class HomeBottomListContent extends StatelessWidget {
  final double horizontalPadding;
  final List<ScheduleCard> items;

  const HomeBottomListContent({
    super.key,
    required this.horizontalPadding,
    required this.items,
  });

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
      itemCount: items.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: horizontalPadding);
      },
      itemBuilder: (contex, index) {
        final item = items[index];
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
            width: horizontalPadding + (horizontalPadding / 2),
          )
        ],
      ),
    );
  }
}
