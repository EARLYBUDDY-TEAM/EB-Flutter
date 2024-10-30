part of '../eb_add_schedule.dart';

final class AddScheduleView extends StatelessWidget {
  final SealedAddScheduleSetting setting;

  const AddScheduleView({
    super.key,
    required this.setting,
  });

  static MaterialPageRoute Function({
    required BuildContext context,
    required Schedule schedule,
    required EBPath? ebPath,
  }) get pageChangeAddSchedule {
    return ({
      required BuildContext context,
      required Schedule schedule,
      required EBPath? ebPath,
    }) =>
        MaterialPageRoute(
          builder: (context) => AddScheduleView(
            setting: ChangeAddScheduleSetting(
              schedule: schedule,
              ebPath: ebPath,
            ),
          ),
        );
  }

  static MaterialPageRoute Function({
    required BuildContext context,
  }) get pageInitAddSchedule {
    return ({
      required BuildContext context,
    }) =>
        MaterialPageRoute(
          builder: (context) => AddScheduleView(
            setting: InitAddScheduleSetting(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AddScheduleBloc(
          homeDelegate: RepositoryProvider.of<HomeDelegate>(context),
          scheduleEvent: RepositoryProvider.of<ScheduleEvent>(context),
          addScheduleDelegate:
              RepositoryProvider.of<AddScheduleDelegate>(context),
          cancelModalViewAction: () {
            Navigator.of(context).pop();
          },
        )..add(SetupAddScheduleView(setting: setting));
      },
      child: const _AddScheduleContent(),
    );
  }

  static MaterialPageRoute pageWriteFindRoute({
    required BuildContext context,
    required Place startPlace,
    required Place endPlace,
    String? parentName,
  }) {
    return FindRouteView.pageWriteFindRoute(
      context: context,
      startPlace: startPlace,
      endPlace: endPlace,
      pageChangeStartPlace: SearchPlaceView.pageChangeStartPlace,
      pageChangeEndPlace: SearchPlaceView.pageChangeEndPlace,
      parentName: parentName,
    );
  }
}

final class _AddScheduleContent extends StatelessWidget {
  final double fontSize = 17;

  const _AddScheduleContent();

  @override
  Widget build(BuildContext context) {
    final bottomSafe = ScreenSize.safeArea.bottom(context);

    return BlocConsumer<AddScheduleBloc, AddScheduleState>(
      listener: (context, state) {
        showAddScheduleResultAlert(
          context: context,
          result: state.result,
        );
      },
      buildWhen: (previous, current) {
        return previous.setting != current.setting;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: _AddScheduleAppBar(
            titleString: _titleString(state.setting),
            popViewAction: () => Navigator.of(context).pop(),
            deleteScheduleAction: _deleteScheduleAction(
              context: context,
              setting: state.setting,
              scheduleTitle: state.schedule.title,
            ),
          ),
          body: SafeArea(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _AddScheduleForms(bottomPadding: bottomSafe + 40 + 20),
                _AddScheduleButton(bottomPadding: bottomSafe),
              ],
            ),
          ),
        );
      },
    );
  }

  String _titleString(SealedAddScheduleSetting setting) {
    switch (setting) {
      case InitAddScheduleSetting():
        return "일정 등록";
      case ChangeAddScheduleSetting():
        return setting.schedule.title;
    }
  }

  Future<bool?> _alertConfirmDeleteSchedule({
    required BuildContext context,
    required String scheduleTitle,
  }) async {
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

  Function()? _deleteScheduleAction({
    required BuildContext context,
    required SealedAddScheduleSetting setting,
    required String scheduleTitle,
  }) {
    switch (setting) {
      case InitAddScheduleSetting():
        return null;
      case ChangeAddScheduleSetting():
        return () async {
          final isDelete = await _alertConfirmDeleteSchedule(
              context: context, scheduleTitle: scheduleTitle);
          if (isDelete == true) {
            context.read<AddScheduleBloc>().add(PressDeleteButton());
          }
        };
    }
  }

  void showAddScheduleResultAlert({
    required BuildContext context,
    required SealedAddScheduleResult result,
  }) {
    String title;
    String? content;
    bool popAddScheduleView;

    switch (result) {
      case CreateAddScheduleResult():
        switch (result.status) {
          case BaseStatus.init:
            return;
          case BaseStatus.success:
            title = "일정을 등록했습니다!";
            popAddScheduleView = true;
          case BaseStatus.fail:
            title = "일정등록에 실패했습니다.";
            content = "네트워크 상태를 확인후 다시 시도해주세요.";
            popAddScheduleView = false;
        }
      case UpdateAddScheduleResult():
        switch (result.status) {
          case BaseStatus.init:
            return;
          case BaseStatus.success:
            title = "일정을 수정했습니다!";
            popAddScheduleView = true;
          case BaseStatus.fail:
            title = "일정수정에 실패했습니다.";
            content = "네트워크 상태를 확인후 다시 시도해주세요.";
            popAddScheduleView = false;
        }
      case DeleteAddScheduleResult():
        switch (result.status) {
          case BaseStatus.init:
            return;
          case BaseStatus.success:
            title = "일정을 삭제했습니다!";
            popAddScheduleView = true;
          case BaseStatus.fail:
            title = "일정삭제에 실패했습니다.";
            content = "네트워크 상태를 확인후 다시 시도해주세요.";
            popAddScheduleView = false;
        }
    }

    EBAlert.showModalPopup(
      context: context,
      title: title,
      content: content,
      actions: [
        EBAlert.makeAction(
          name: '확인',
          onPressed: () {
            context.read<AddScheduleBloc>().add(
                  SetAddScheduleResultStatus(
                    result: SealedAddScheduleResult.init(),
                  ),
                );
            Navigator.of(context).pop();
            if (popAddScheduleView) {
              Navigator.of(context).pop();
            }
          },
          isDefaultAction: true,
        )
      ],
    );
  }
}
