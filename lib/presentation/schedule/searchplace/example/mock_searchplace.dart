part of 'searchplace_example.dart';

class _MockSearchPlace extends StatelessWidget {
  const _MockSearchPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPlaceView(
        setting: SearchPlaceSetting.departure,
        searchPlaceState: SearchPlaceState.mockView(),
      ),
    );
  }
}
