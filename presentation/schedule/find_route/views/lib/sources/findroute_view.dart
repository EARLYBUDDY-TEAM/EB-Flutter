part of '../eb_find_route.dart';

final class FindRouteView extends StatelessWidget {
  final Place startPlace;
  final Place endPlace;
  final String? parentName;
  Function()? backAction;
  Function()? cancelAction;

  FindRouteView({
    super.key,
    required this.startPlace,
    required this.endPlace,
    this.parentName,
    this.backAction,
    this.cancelAction,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FindRouteBloc(
        startPlace: startPlace,
        endPlace: endPlace,
        findRouteRepository:
            RepositoryProvider.of<FindRouteRepository>(context),
      )..add(const OnAppearFindRouteView()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _FindRouteAppBar(
          parentName: parentName,
          backAction: backAction,
          cancelAction: cancelAction,
        ),
        body: Column(
          children: [
            _FindRouteInfoView(
              startName: startPlace.name,
              endName: endPlace.name,
            ),
            const _FindRouteListView(),
          ],
        ),
      ),
    );
  }
}

// final class FindRouteScaffold extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }