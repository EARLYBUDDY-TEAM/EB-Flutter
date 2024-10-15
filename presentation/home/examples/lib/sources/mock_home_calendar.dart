part of 'home_example.dart';

final class MockHomeCalendar extends StatelessWidget {
  const MockHomeCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 200),
              HomeCalendar(),
            ],
          ),
        ),
      ),
    );
  }
}
