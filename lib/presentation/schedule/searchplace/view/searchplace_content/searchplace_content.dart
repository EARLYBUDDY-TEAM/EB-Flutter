part of '../searchplace_view.dart';

final class _SearchPlaceContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          title: _SearchPlaceSearchBar(),
          scrolledUnderElevation: 0,
          bottomOpacity: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: _SearchPlaceListView(),
      ),
    );
  }
}
