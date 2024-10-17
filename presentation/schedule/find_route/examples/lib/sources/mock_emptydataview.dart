part of 'findroute_example.dart';

final class MockEmptyDataView extends StatelessWidget {
  const MockEmptyDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: EmptyDataView(),
        ),
      ),
    );
  }
}
