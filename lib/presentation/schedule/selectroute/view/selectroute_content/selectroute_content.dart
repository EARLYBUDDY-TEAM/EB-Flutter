part of '../selectroute_view.dart';

class _SelectRouteContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _SelectRouteInfoView(),
        _SelectRouteSortView(),
        _SelectRouteListView(),
      ],
    );
  }
}
