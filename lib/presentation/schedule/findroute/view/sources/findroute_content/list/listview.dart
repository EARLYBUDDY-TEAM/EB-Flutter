part of '../../findroute_view.dart';

class _FindRouteListView extends StatelessWidget {
  const _FindRouteListView();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: BlocBuilder<FindRouteBloc, FindRouteState>(
        builder: (context, findRouteState) {
          final ebRoute = findRouteState.ebRoute;
          final viewState = findRouteState.viewState;
          if (ebRoute == null) {
            return const Center(
              child: Text('empty ebRoute...'),
            );
          } else {
            return ListView.separated(
              itemCount: ebRoute.ebPaths.length,
              itemBuilder: (context, index) {
                return FindRouteListItem(
                  ebPath: ebRoute.ebPaths[index],
                  lineOfPath: viewState.transportLineOfRoute.lineOfRoute[index],
                );
              },
              separatorBuilder: ((context, index) {
                return const Divider(height: 1);
              }),
              padding: const EdgeInsets.all(0.0),
            );
          }
        },
      ),
    );
  }
}
