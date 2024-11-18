part of '../../../../../eb_home.dart';

final class _MiddleTransportInfoCard extends StatelessWidget {
  final int myIndex;
  final double cardWidth;
  final InfoMiddleTransportCardState cardState;
  final StreamRealTimeInfo? streamBusRealTimeInfo;

  const _MiddleTransportInfoCard({
    super.key,
    required this.myIndex,
    required this.cardWidth,
    required this.cardState,
    this.streamBusRealTimeInfo,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamBusRealTimeInfo,
      builder: (context, snapshot) {
        final realTimeInfoList = snapshot.data;

        final curRealTimeInfo = _getRealTimeInfo(
          realTimeInfoList: realTimeInfoList,
        );

        final scaleTrigger = _getScaleTrigger(curRealTimeInfo: curRealTimeInfo);

        return _MiddleTransportCardWithScale(
          scaleTrigger: scaleTrigger,
          cardWidth: cardWidth,
          child: _middleTransportInfoCardContent(
            realTimeInfoList: realTimeInfoList,
            curRealTimeInfo: curRealTimeInfo,
          ),
        );
      },
    );
  }

  bool _getScaleTrigger({
    required RealTimeInfo? curRealTimeInfo,
  }) {
    if (streamBusRealTimeInfo == null) {
      return false;
    }

    return (curRealTimeInfo != null);
  }

  Widget _middleTransportInfoCardContent({
    required List<RealTimeInfo>? realTimeInfoList,
    required RealTimeInfo? curRealTimeInfo,
  }) {
    return MiddleTransportCardForm(
      verticalPadding: 8,
      horizontalPadding: 8,
      child: Row(
        children: [
          Expanded(
            child: _LeftDispatchColumn(
              selectedTransport: cardState.selectedTransport,
              transportSubPath: cardState.subPath,
              expectTotalMinute: cardState.expectTotalMinute,
              myIndex: myIndex,
              realTimeInfoList: realTimeInfoList,
            ),
          ),
          const SizedBox(width: 4),
          _RightDisPatchColumn(
            index: myIndex,
            realTimeInfo: curRealTimeInfo,
          ),
        ],
      ),
    );
  }

  RealTimeInfo? _getRealTimeInfo({
    required List<RealTimeInfo>? realTimeInfoList,
  }) {
    if (realTimeInfoList == null) {
      return null;
    }

    final selectedTransport = cardState.selectedTransport;
    if (selectedTransport == null) {
      return null;
    }
    String transportName;
    switch (selectedTransport) {
      case Subway():
        transportName = selectedTransport.type;
      case Bus():
        transportName = selectedTransport.number;
    }

    for (var realTimeInfo in realTimeInfoList) {
      if (realTimeInfo.transportName == transportName) {
        return realTimeInfo;
      }
    }

    return null;
  }
}
