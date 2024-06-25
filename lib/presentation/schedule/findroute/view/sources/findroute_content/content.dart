part of '../findroute_view.dart';

class _FindRouteContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _FindRouteInfoView(),
        Expanded(
          child: NestedHeaderScrollView(
            header: const _FindRouteSortView(),
            content: const _FindRouteListView(),
          ),
        ),
      ],
    );
  }
}
