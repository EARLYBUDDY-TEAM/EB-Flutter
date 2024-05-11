part of 'searchplace_example.dart';

class MockSearchPlace extends StatelessWidget {
  final _searchPlaceBloc =
      SearchPlaceBloc(searchPlaceState: SearchPlaceState.mock());

  MockSearchPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPlaceView(
        searchPlaceContent: SearchPlaceContent(
          searchPlaceBloc: _searchPlaceBloc,
        ),
      ),
    );
  }
}
