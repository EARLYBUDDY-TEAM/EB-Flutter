part of 'searchplace_example.dart';

final class _MockSearchPlace extends StatelessWidget {
  final delegate = SearchPlaceDelegate();

  _MockSearchPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => delegate,
        child: SearchPlaceView(
          setting: SearchPlaceSetting.departure,
          delegate: RepositoryProvider.of<SearchPlaceDelegate>(context),
          searchPlaceState: SearchPlaceState.mockView(),
        ),
      ),
    );
  }
}
