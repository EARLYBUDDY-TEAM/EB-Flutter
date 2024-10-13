part of '../../eb_home.dart';

final class HomeBottomListView extends StatelessWidget {
  final double horizontalPadding;
  const HomeBottomListView({
    super.key,
    this.horizontalPadding = 20,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        final flagSelectDay = (previous.bottomScheduleListState.selectedDay !=
            current.bottomScheduleListState.selectedDay);

        final flagGetAllScheduleCard =
            current.status.getAllScheduleCard == BaseStatus.success;

        return flagSelectDay || flagGetAllScheduleCard;
      },
      builder: (context, state) {
        context
            .read<HomeBloc>()
            .add(const SetHomeStatus(getAllScheduleCard: BaseStatus.init));

        log("view reload ... ");
        return HomeBottomListContent(
          horizontalPadding: horizontalPadding,
          scheduleList: state.bottomScheduleListState.getSelectedDayCardList,
        );
      },
    );
  }
}

final class HomeBottomListContent extends StatefulWidget {
  final double horizontalPadding;
  final List<Schedule> scheduleList;

  const HomeBottomListContent({
    super.key,
    required this.horizontalPadding,
    required this.scheduleList,
  });

  @override
  State<StatefulWidget> createState() => HomeBottomListContentState();
}

// Future Builder ??
final class HomeBottomListContentState extends State<HomeBottomListContent> {
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
      itemCount: widget.scheduleList.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: widget.horizontalPadding);
      },
      itemBuilder: (contex, index) {
        final item = widget.scheduleList[index];
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            return await _confirmDismiss(
              context: contex,
              direction: direction,
              item: item,
            );
          },
          onDismissed: (direction) {
            _onDismissed(context: contex, direction: direction);
          },
          background: _swipeDeleteWidget(),
          child: BottomScheduleCardView(schedule: item),
        );
      },
    );
  }

  Widget _swipeDeleteWidget() {
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

// logic
extension on HomeBottomListContentState {
  void _onDismissed({
    required BuildContext context,
    required DismissDirection direction,
  }) {
    context
        .read<HomeBloc>()
        .add(const SetHomeStatus(deleteScheduleCard: BaseStatus.init));
    setState(() {});
    _snackBarSuccessDeleteSuccessScheduleCard(context);
  }

  Future<bool> _confirmDismiss({
    required BuildContext context,
    required DismissDirection direction,
    required Schedule item,
  }) async {
    if (direction != DismissDirection.endToStart) {
      return false;
    }

    final isDelete = await _alertConfirmDeleteScheduleCard(
      context,
      item.title,
    );

    if (isDelete != true) {
      return false;
    }

    final bool deleteScheduleResult =
        await _getDeleteScheduleResult(context, item);

    if (deleteScheduleResult == false) {
      _alertFailDeleteFailScheduleCard(context);
    }

    return deleteScheduleResult;
  }

  Future<bool> _getDeleteScheduleResult(
    BuildContext context,
    Schedule item,
  ) async {
    final homeBloc = context.read<HomeBloc>()
      ..add(DeleteScheduleCard(schedule: item));

    final homeState = await homeBloc.stream.firstWhere((state) {
      return state.status.deleteScheduleCard != BaseStatus.init;
    });
    final deleteResult = homeState.status.deleteScheduleCard;
    switch (deleteResult) {
      case BaseStatus.success:
        return true;
      default:
        return false;
    }
  }
}

// alert
extension on HomeBottomListContentState {
  Future<bool?> _alertConfirmDeleteScheduleCard(
    BuildContext context,
    String scheduleTitle,
  ) async {
    return await EBAlert.showModalPopup(
      context: context,
      title: '$scheduleTitle 일정을 삭제하시겠습니까?',
      actions: [
        EBAlert.makeAction(
          name: '취소',
          onPressed: () => Navigator.of(context).pop(false),
          isDefaultAction: true,
        ),
        EBAlert.makeAction(
          name: '삭제',
          onPressed: () => Navigator.of(context).pop(true),
          isDestructiveAction: true,
        ),
      ],
    );
  }

  void _alertFailDeleteFailScheduleCard(BuildContext context) {
    EBAlert.showModalPopup(
      context: context,
      title: '일정삭제에 실패했습니다.',
      content: '네트워크 상태를 확인해주세요.',
      actions: [
        EBAlert.makeAction(
          name: '확인',
          onPressed: () {
            context
                .read<HomeBloc>()
                .add(const SetHomeStatus(deleteScheduleCard: BaseStatus.init));
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
        ),
      ],
    );
  }

  void _snackBarSuccessDeleteSuccessScheduleCard(BuildContext context) {
    final snackBar = EBSnackBar(text: '일정을 삭제했습니다.');
    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((_) {
      context
          .read<HomeBloc>()
          .add(const SetHomeStatus(deleteScheduleCard: BaseStatus.init));
    });
  }
}
