part of '../findroute_example.dart';

final Transport mockSelectedTransport = Subway.mock();
// final String mockStartName = '가산디지털단지' * 10;
const String mockStartName = '가산';
const double mockFontSize = 20;
final RealTimeInfo mockRealTimeInfo = RealTimeInfo.mock();
final TransportMap mockTransportMap =
    createTransportMap([mockSelectedTransport]);

final class _MockDetailStartInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = ScreenSize.width(context) - 40;
    return _background(
      width: width,
      child: _content(),
    );
  }

  Widget _content() {
    return Row(
      children: [
        Expanded(child: _MockDetailStartInfoText()),
        DetailShowMapButtonContent(
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _background({
    required Widget child,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _box(),
              _box(),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }

  Widget _box() {
    return Container(
      width: 40,
      height: 100,
      color: EBColors.random,
    );
  }
}

final class _MockDetailStartInfoPopupButtonContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DetailStartInfoPopupButtonContent(
      selectedTransport: mockSelectedTransport,
      startName: mockStartName,
      fontSize: mockFontSize,
      realTimeInfo: mockRealTimeInfo,
    );
  }
}

final class _MockDetailStartInfoText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DetailStartInfoText(
      selectedTransport: mockSelectedTransport,
      startName: mockStartName,
      fontSize: mockFontSize,
    );
  }
}
