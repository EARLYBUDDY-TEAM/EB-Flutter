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
  EBSubPath get mockTransportSubPath {
    final path = EBPath.mockDongToGwang();

    EBSubPath? subPath;
    for (var curSubPath in path.ebSubPaths) {
      if (curSubPath.type == 2) {
        subPath = curSubPath;
        break;
      }
    }
    subPath ??= EBSubPath.mockBus();

    return subPath;

    // final newSubPath = subPath.copyWith(transports: []);

    // return newSubPath;
  }

  Widget _info() {
    return MiddleTransportInfo(
      trasnportSubPath: mockTransportSubPath,
      streamRealTimeInfo: const Stream.empty(),
    );
  }
}
