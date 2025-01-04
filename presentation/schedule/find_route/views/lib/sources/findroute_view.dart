part of '../eb_find_route.dart';

final class FindRouteView extends StatelessWidget {
  final Place? startPlace;
  final Place? endPlace;
  final SealedFindRouteSetting setting;
  final String? parentName;
  final DateTime scheduleTime;

  const FindRouteView({
    super.key,
    this.parentName,
    required this.startPlace,
    required this.endPlace,
    required this.setting,
    required this.scheduleTime,
  });

  static MaterialPageRoute pageReadFindRoute({
    required BuildContext context,
    required Place startPlace,
    required Place endPlace,
    required EBPath path,
    required DateTime scheduleTime,
    String? parentName,
  }) {
    return MaterialPageRoute(
      builder: (context) => FindRouteView(
        startPlace: startPlace,
        endPlace: endPlace,
        setting: ReadFindRouteSetting(path: path),
        parentName: parentName,
        scheduleTime: scheduleTime,
      ),
    );
  }

  static MaterialPageRoute pageWriteFindRoute({
    required BuildContext context,
    required DateTime scheduleTime,
    required Place? startPlace,
    required Place? endPlace,
    required MaterialPageRoute Function(BuildContext context)
        pageChangeStartPlace,
    required MaterialPageRoute Function(BuildContext context)
        pageChangeEndPlace,
    String? parentName,
  }) {
    return MaterialPageRoute(
      builder: (context) => FindRouteView(
        startPlace: startPlace,
        endPlace: endPlace,
        scheduleTime: scheduleTime,
        setting: WriteFindRouteSetting(
          pageChangeStartPlace: pageChangeStartPlace,
          pageChangeEndPlace: pageChangeEndPlace,
        ),
        parentName: parentName,
      ),
    );
  }

  static MaterialPageRoute pageWriteAndUpdateFindRoute({
    required BuildContext context,
    required SchedulePath schedulePath,
    required Place? startPlace,
    required Place? endPlace,
    required MaterialPageRoute Function(BuildContext context)
        pageChangeStartPlace,
    required MaterialPageRoute Function(BuildContext context)
        pageChangeEndPlace,
    String? parentName,
  }) {
    final scheduleTime = schedulePath.schedule.time;
    return MaterialPageRoute(
      builder: (context) => FindRouteView(
        startPlace: startPlace,
        endPlace: endPlace,
        scheduleTime: scheduleTime,
        setting: WriteAndUpdateFindRouteSetting(
          schedulePath: schedulePath,
          pageChangeStartPlace: pageChangeStartPlace,
          pageChangeEndPlace: pageChangeEndPlace,
        ),
        parentName: parentName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FindRouteBloc(
        loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
        findRouteDelegate: RepositoryProvider.of<FindRouteDelegate>(context),
        addScheduleDelegate:
            RepositoryProvider.of<AddScheduleDelegate>(context),
        homeDelegate: RepositoryProvider.of<HomeDelegate>(context),
        findRouteRepository:
            RepositoryProvider.of<FindRouteRepository>(context),
        scheduleEvent: RepositoryProvider.of<ScheduleEvent>(context),
        findRouteState: FindRouteState(
          searchPlaceInfo: SearchPlaceInfo(
            startPlace: startPlace,
            endPlace: endPlace,
          ),
          setting: setting,
          scheduleTime: scheduleTime,
        ),
      )..add(SetupFindRouteView(setting: setting)),
      child: FindRouteScaffold(
        parentName: parentName,
      ),
    );
  }
}

final class FindRouteScaffold extends StatelessWidget {
  final String? parentName;
  final selectRouteName = '경로 목록';

  const FindRouteScaffold({
    super.key,
    required this.parentName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FindRouteBloc, FindRouteState>(
      listener: (context, state) {
        _showUpdateScheduleResultAlert(
          context: context,
          result: state.updateResult,
        );
      },
      buildWhen: (previous, current) {
        final flag1 = previous.contentStatus != current.contentStatus;
        final flag2 = previous.routeInfo != current.routeInfo;

        return (flag1 || flag2);
      },
      builder: (context, state) {
        final contentStatus = state.contentStatus;
        final setting = state.setting;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _FindRouteAppBar(
            titleText: _titleText(setting: setting),
            parentName: _parentName(
              setting: setting,
              contentStatus: contentStatus,
            ),
            backAction: _backAction(
              contentStatus: contentStatus,
              context: context,
            ),
            cancelAction: () =>
                context.read<FindRouteBloc>().add(const CancelViewAction()),
          ),
          body: Stack(
            children: _children(
              contentStatus: contentStatus,
              setting: setting,
            ),
          ),
        );
      },
    );
  }

  String _titleText({
    required SealedFindRouteSetting setting,
  }) {
    return (setting is ReadFindRouteSetting) ? "경로 보기" : '경로 선택';
  }

  String? _parentName({
    required SealedFindRouteSetting setting,
    required SealedFindRouteContentStatus contentStatus,
  }) {
    if (setting is ReadFindRouteSetting) {
      return null;
    }
    return (contentStatus is DetailFindRouteStatus)
        ? selectRouteName
        : parentName;
  }

  List<Widget> _children({
    required SealedFindRouteContentStatus contentStatus,
    required SealedFindRouteSetting setting,
  }) {
    final List<Widget> listWidget = [
      SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _FindRouteSwitchContent(),
      )
    ];

    if (setting is ReadFindRouteSetting) {
      return listWidget;
    }

    if (contentStatus is DetailFindRouteStatus) {
      listWidget.add(_SelectRouteButton());
    }

    return listWidget;
  }

  Function() _backAction({
    required BuildContext context,
    required SealedFindRouteContentStatus contentStatus,
  }) {
    switch (contentStatus) {
      case DetailFindRouteStatus():
        return () => _showSelectRouteView(context);
      default:
        return () => _popFindRouteViewInNav(context);
    }
  }

  void _popFindRouteViewInNav(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _showSelectRouteView(BuildContext context) {
    final state = context.read<FindRouteBloc>().state;
    final contentStatus = state.createSelectContentStatus();

    context.read<FindRouteBloc>().add(
          SetFindRouteContentStatus(
            contentStatus: contentStatus,
          ),
        );
  }

  void _showUpdateScheduleResultAlert({
    required BuildContext context,
    required BaseStatus result,
  }) {
    String title;
    String? content;
    bool popAddScheduleView;

    switch (result) {
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

    EBAlert.showModalPopup(
      context: context,
      title: title,
      content: content,
      actions: [
        EBAlert.makeAction(
          name: '확인',
          onPressed: () {
            Navigator.of(context).pop();
            context.read<FindRouteBloc>().add(
                  const SetUpdateResult(
                    result: BaseStatus.init,
                  ),
                );
            if (popAddScheduleView) {
              context.read<FindRouteBloc>().add(const CancelViewAction());
            }
          },
          isDefaultAction: true,
        ),
      ],
    );
  }
}

final class _FindRouteSwitchContent extends StatelessWidget {
  final double headerHeight = 100;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindRouteBloc, FindRouteState>(
      buildWhen: (previous, current) {
        return previous.contentStatus != current.contentStatus;
      },
      builder: (context, state) {
        final contentStatus = state.contentStatus;

        switch (contentStatus) {
          case EmptyDataFindRouteStatus():
            return FindRouteEmptyDataView(
              headerHeight: headerHeight,
            );
          default:
            return Column(
              children: [
                Expanded(
                  child: _FindRouteScrollView(
                    headerHeight: headerHeight,
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}
