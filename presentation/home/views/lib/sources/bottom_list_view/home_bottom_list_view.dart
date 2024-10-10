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
        return (previous.scheduleCardMap != current.scheduleCardMap);
      },
      builder: (context, state) {
        return HomeBottomListContent(
          horizontalPadding: horizontalPadding,
          scheduleCardList: state.scheduleCardMap.getSelectedDayCardList,
        );
      },
    );
  }
}

final class HomeBottomListContent extends StatefulWidget {
  final double horizontalPadding;
  final List<ScheduleCard> scheduleCardList;

  const HomeBottomListContent({
    super.key,
    required this.horizontalPadding,
    required this.scheduleCardList,
  });

  @override
  State<StatefulWidget> createState() => HomeBottomListContentState();
}

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
      itemCount: widget.scheduleCardList.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: widget.horizontalPadding);
      },
      itemBuilder: (contex, index) {
        final item = widget.scheduleCardList[index];
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            if (direction != DismissDirection.endToStart) {
              return false;
            }
            final bool swipeResult =
                await _swipeDeleteAction(contex, item, index);
            return swipeResult;
          },
          background: _swipeDeleteWidget(),
          child: BottomScheduleCardView(scheduleCard: item),
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

extension on HomeBottomListContentState {
  Future<bool> _swipeDeleteAction(
    BuildContext context,
    ScheduleCard item,
    int index,
  ) async {
    final isDelete = await _alertConfirmDeleteScheduleCard(
      context,
      item.title,
    );

    if ((isDelete != null) && isDelete) {
      final homeBloc = context.read<HomeBloc>()
        ..add(DeleteScheduleCard(scheduleID: item.scheduleID));

      final homeState = await homeBloc.stream.firstWhere((state) {
        return state.status.deleteScheduleCard != BaseStatus.init;
      });
      final deleteResult = homeState.status.deleteScheduleCard;
      switch (deleteResult) {
        case BaseStatus.success:
          _snackBarSuccessDeleteSuccessScheduleCard(context);
          setState(() {
            widget.scheduleCardList.removeAt(index);
          });
          return true;
        case BaseStatus.fail:
          _alertFailDeleteFailScheduleCard(context);
          return false;
        default:
          return false;
      }
    }
    return false;
  }
}

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
