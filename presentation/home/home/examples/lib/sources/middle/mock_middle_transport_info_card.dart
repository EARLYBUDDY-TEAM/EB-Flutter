part of '../home_example.dart';

final class MockMiddleTransportArrivalCard extends StatelessWidget {
  const MockMiddleTransportArrivalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: MiddleTransportArrivalCard(),
    );
  }
}

final class MockMiddleTransportInfoCard extends StatelessWidget {
  const MockMiddleTransportInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = ScreenSize.width(context) - 40;

    return MiddleTransportInfoCard(
      myIndex: 0,
      cardWidth: width,
      cardState: _cardState(),
      streamBusRealTimeInfo: const Stream.empty(),
    );
  }

  InfoMiddleTransportCardState _cardState() {
    final subPath = _subPath();

    return InfoMiddleTransportCardState(
      selectedTransport: subPath.transportList.first,
      expectStartTime: DateTime.now(),
      expectTotalMinute: 100,
      subPath: subPath,
    );
  }

  EBSubPath _subPath() {
    return EBSubPath.mockGasanToSuwon();
  }
}
