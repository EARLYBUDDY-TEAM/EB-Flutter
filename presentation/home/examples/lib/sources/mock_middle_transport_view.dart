part of 'home_example.dart';

final class MockMiddleTransportView extends StatelessWidget {
  const MockMiddleTransportView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MiddleTransportForm(
                  content: _imminent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _plain_text() {
    return const MiddleTransportAddSchedule();
  }

  Widget _info() {
    return const MiddleTransportInfo(
      stream: Stream.empty(),
    );
  }

  Widget _imminent() {
    return const MiddleTransportArrival();
  }
}
