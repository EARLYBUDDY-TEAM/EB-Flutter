part of '../../../../../eb_home.dart';

final class _MiddleTransportInfoCardStatefulView extends StatefulWidget {
  final int index;
  final InfoMiddleTransportCardState cardState;
  final Stream<RealTimeInfoMap>? streamRealTimeInfo;

  const _MiddleTransportInfoCardStatefulView({
    super.key,
    required this.index,
    required this.cardState,
    this.streamRealTimeInfo,
  });

  @override
  State<StatefulWidget> createState() =>
      _MiddleTransportInfoCardStatefulViewState();
}

final class _MiddleTransportInfoCardStatefulViewState
    extends State<_MiddleTransportInfoCardStatefulView> {
  bool isFirstStream = true;
  late double _scale;

  final double _maxScale = 1.0;
  final double _minScale = 0.95;

  @override
  void initState() {
    _scale = _minScale;
    super.initState();
  }

  @override
  void didUpdateWidget(
      covariant _MiddleTransportInfoCardStatefulView oldWidget) {
    final isFirst = (widget.streamRealTimeInfo != null) ? true : false;
    isFirstStream = isFirst;
    _scale = _minScale;
    super.didUpdateWidget(oldWidget);
  }

  _setScaleEffect({
    required RealTimeInfoMap? realTimeInfoList,
  }) {
    if (!isFirstStream) {
      return;
    }

    if ((realTimeInfoList == null) || (realTimeInfoList.isEmpty)) {
      return;
    }

    isFirstStream = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _scale = _maxScale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      curve: Curves.easeOutQuart,
      duration: const Duration(milliseconds: 450),
      child: StreamBuilder(
        stream: widget.streamRealTimeInfo,
        builder: (context, snapshot) {
          final realTimeInfoMap = snapshot.data;

          _setScaleEffect(
            realTimeInfoList: realTimeInfoMap,
          );

          return MiddleTransportCardForm(
            verticalPadding: 10,
            horizontalPadding: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _LeftDispatchColumn(
                  selectedTransport: widget.cardState.selectedTransport,
                  transportSubPath: widget.cardState.subPath,
                  expectTotalMinute: widget.cardState.expectTotalMinute,
                  index: widget.index,
                ),
                _RightDisPatchColumn(
                  index: widget.index,
                  realTimeInfo: _getRealTimeInfo(
                    realTimeInfoMap: realTimeInfoMap,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  RealTimeInfo? _getRealTimeInfo({
    required RealTimeInfoMap? realTimeInfoMap,
  }) {
    if (realTimeInfoMap == null) {
      return null;
    }

    final selectedTransport = widget.cardState.selectedTransport;
    if (selectedTransport == null) {
      return null;
    }
    String transportNumber;
    switch (selectedTransport) {
      case Subway():
        transportNumber = selectedTransport.type;
      case Bus():
        transportNumber = selectedTransport.number;
    }

    return realTimeInfoMap[transportNumber];
  }
}
