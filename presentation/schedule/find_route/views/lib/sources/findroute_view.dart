part of '../eb_find_route.dart';

final class FindRouteView extends StatelessWidget {
  final Place startPlace;
  final Place endPlace;
  final SealedFindRouteSetting setting;
  final String? parentName;

  const FindRouteView({
    super.key,
    this.parentName,
    required this.startPlace,
    required this.endPlace,
    required this.setting,
  });

  static MaterialPageRoute pageReadFindRoute({
    required Place startPlace,
    required Place endPlace,
    required List<EBSubPath> subPaths,
    String? parentName,
  }) {
    return MaterialPageRoute(
      builder: (_) => FindRouteView(
        startPlace: startPlace,
        endPlace: endPlace,
        setting: ReadFindRouteSetting(subPaths: subPaths),
        parentName: parentName,
      ),
    );
  }

  static MaterialPageRoute pageWriteFindRoute({
    required Place startPlace,
    required Place endPlace,
    required MaterialPageRoute Function(BuildContext context)
        pageChangeStartPlace,
    required MaterialPageRoute Function(BuildContext context)
        pageChangeEndPlace,
    String? parentName,
  }) {
    return MaterialPageRoute(
      builder: (_) => FindRouteView(
        startPlace: startPlace,
        endPlace: endPlace,
        setting: WriteFindRouteSetting(
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
        findRouteState: FindRouteState(
          searchPlaceInfo: SearchPlaceInfo(
            startPlace: startPlace,
            endPlace: endPlace,
          ),
          setting: setting,
        ),
      )..add(SetupFindRouteView(setting: setting)),
      child: _FindRouteScaffold(
        parentName: parentName,
      ),
    );
  }
}

final class _FindRouteScaffold extends StatelessWidget {
  final String? parentName;
  final selectRouteName = '경로 목록';

  const _FindRouteScaffold({
    required this.parentName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindRouteBloc, FindRouteState>(
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
            parentName: (contentStatus is DetailFindRouteStatus)
                ? selectRouteName
                : parentName,
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

  List<Widget> _children({
    required SealedFindRouteContentStatus contentStatus,
    required SealedFindRouteSetting setting,
  }) {
    final List<Widget> listWidget = [
      Column(
        children: [_FindRouteSwitchContent()],
      ),
    ];

    if ((setting is WriteFindRouteSetting) &&
        (contentStatus is DetailFindRouteStatus)) {
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
            return _FindRouteEmptyDataView(
              headerHeight: headerHeight,
            );
          default:
            return _FindRouteScrollView(
              headerHeight: headerHeight,
            );
        }
      },
    );
  }
}
