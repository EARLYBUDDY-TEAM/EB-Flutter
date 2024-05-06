part of 'searchplace_example.dart';

class MockSearchPlace extends StatelessWidget {
  const MockSearchPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SearchPlaceView(),
    );
  }
}
