part of '../eb_find_route.dart';

final class FindRouteView extends StatelessWidget {
  final Place startPlace;
  final Place endPlace;
  final String? parentName;

  const FindRouteView({
    super.key,
    required this.startPlace,
    required this.endPlace,
    this.parentName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FindRouteBloc(
        startPlace: startPlace,
        endPlace: endPlace,
        searchPlaceDelegate:
            RepositoryProvider.of<SearchPlaceDelegate>(context),
        addScheduleDelegate:
            RepositoryProvider.of<AddScheduleDelegate>(context),
        findRouteRepository:
            RepositoryProvider.of<FindRouteRepository>(context),
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
          body: Column(
            children: [
              _FindRouteInfoView(),
              const _FindRouteSwitchContent(),
            ],
          ),
        );
      },
    );
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
