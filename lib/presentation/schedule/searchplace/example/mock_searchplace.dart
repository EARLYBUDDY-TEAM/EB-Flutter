part of 'searchplace_example.dart';

class _MockSearchPlace extends StatelessWidget {
  final _searchPlaceBloc =
      SearchPlaceBloc(searchPlaceState: SearchPlaceState.mockView());

  _MockSearchPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPlaceView(searchPlaceBloc: _searchPlaceBloc),
    );
  }
}
