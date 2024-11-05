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
                  content: _info(),
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

  Widget _imminent() {
    return const MiddleTransportArrival();
  }
}

extension on MockMiddleTransportView {
  Widget _info() {
    final transportList = mockTransportSubPath.transportList;

    Transport? selectedTransport;

    switch (transportList) {
      case SubwayList():
        selectedTransport = transportList.subwayList.firstOrNull;
      case BusList():
        selectedTransport = transportList.busList.firstOrNull;
      default:
        selectedTransport = null;
    }

    return MiddleTransportInfo(
      selectedTransport: selectedTransport,
      trasnportSubPath: mockTransportSubPath,
      streamRealTimeInfo: const Stream.empty(),
    );
  }
}
