part of '../../../../../eb_home.dart';

final class MiddleTransportInfoCard extends StatelessWidget {
  final int index;
  final InfoMiddleTransportCardState cardState;
  final Stream<RealTimeInfo?>? streamRealTimeInfo;

  const MiddleTransportInfoCard({
    super.key,
    required this.index,
    required this.cardState,
    this.streamRealTimeInfo,
  });

  @override
  Widget build(BuildContext context) {
    return MiddleTransportCardForm(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _LeftDispatchColumn(
            selectedTransport: cardState.selectedTransport,
            transportSubPath: cardState.subPath,
            expectTotalMinute: cardState.expectTotalMinute,
            index: index,
          ),
          _RightDisPatchColumn(
            index: index,
            streamRealTimeInfo: streamRealTimeInfo,
          ),
        ],
      ),
    );
  }
}
