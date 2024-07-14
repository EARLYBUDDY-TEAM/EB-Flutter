part of 'searchplace_example.dart';

final class _MockSearchPlace extends StatelessWidget {
  final delegate = SearchPlaceDelegate();

  _MockSearchPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => SearchPlaceDelegate(),
        child: SearchPlaceView(
          setting: SearchPlaceSetting.departure,
          searchPlaceState: SearchPlaceState.mockView(),
        ),
      ),
    );
  }
}
