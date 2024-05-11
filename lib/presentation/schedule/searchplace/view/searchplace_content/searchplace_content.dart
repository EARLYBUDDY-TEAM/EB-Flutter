part of '../searchplace_view.dart';

final class SearchPlaceContent extends StatelessWidget {
  final SearchPlaceBloc _searchPlaceBloc;

  SearchPlaceContent({
    super.key,
    SearchPlaceBloc? searchPlaceBloc,
  }) : _searchPlaceBloc = searchPlaceBloc ?? SearchPlaceBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchPlaceBloc,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            _SearchPlaceSearchBar(),
            _SearchPlaceListView(),
          ],
        ),
      ),
    );
  }
}
