part of '../selectroute_view.dart';

class _SelectRouteContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SelectRouteInfoView(),
        Expanded(
          child: NestedHeaderScrollView(
            header: const _SelectRouteSortView(),
            content: const _SelectRouteListView(),
          ),
        ),
      ],
    );
  }
}
