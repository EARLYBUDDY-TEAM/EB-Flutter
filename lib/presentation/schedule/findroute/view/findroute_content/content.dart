part of '../findroute_view.dart';

class _FindRouteContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _FindRouteInfoView(),
        Center(child: Text('testemptyview')),
        // Expanded(
        //   child: NestedHeaderScrollView(
        //     header: const _FindRouteSortView(),
        //     content: const _FindRouteListView(),
        //   ),
        // ),
      ],
    );
  }
}
