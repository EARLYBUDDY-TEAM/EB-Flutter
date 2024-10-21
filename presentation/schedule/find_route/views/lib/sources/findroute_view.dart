part of '../eb_find_route.dart';

final class FindRouteView extends StatelessWidget {
  final Place startPlace;
  final Place endPlace;
  final MaterialPageRoute Function(BuildContext) pageChangeStartPlace;
  final MaterialPageRoute Function(BuildContext) pageChangeEndPlace;
  final String? parentName;

  const FindRouteView({
    super.key,
    this.parentName,
    required this.startPlace,
    required this.endPlace,
    required this.pageChangeStartPlace,
    required this.pageChangeEndPlace,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FindRouteBloc(
        loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
        findRouteDelegate: RepositoryProvider.of<FindRouteDelegate>(context),
        addScheduleDelegate:
            RepositoryProvider.of<AddScheduleDelegate>(context),
        findRouteRepository:
            RepositoryProvider.of<FindRouteRepository>(context),
        findRouteState: FindRouteState(
          searchPlaceInfo: SearchPlaceInfo(
            startPlace: startPlace,
            endPlace: endPlace,
            pageChangeStartPlace: pageChangeStartPlace,
            pageChangeEndPlace: pageChangeEndPlace,
          ),
        ),
      )..add(const OnAppearFindRouteView()),
      child: _FindRouteScaffold(
        parentName: parentName,
      ),
    );
  }
}

final class _FindRouteScaffold extends StatelessWidget {
  final String? parentName;

  const _FindRouteScaffold({
    required this.parentName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindRouteBloc, FindRouteState>(
      buildWhen: (previous, current) {
        return previous.contentStatus != current.contentStatus;
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _FindRouteAppBar(
            parentName: parentName,
            backAction: _backAction(
              contentStatus: state.contentStatus,
              context: context,
            ),
            cancelAction: () =>
                context.read<FindRouteBloc>().add(const CancelViewAction()),
          ),
          body: Stack(
            children: _children(state.contentStatus),
          ),
        );
      },
    );
  }

  List<Widget> _children(SealedFindRouteContentStatus contentStatus) {
    final List<Widget> listWidget = [
      Column(
        children: [_FindRouteSwitchContent()],
      ),
    ];

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
    context.read<FindRouteBloc>().add(
          SetFindRouteContentStatus(
            contentStatus: SelectFindRouteStatus(),
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
        final cotentStatus = state.contentStatus;

        switch (cotentStatus) {
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
