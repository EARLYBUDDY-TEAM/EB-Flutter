part of '../../../../../eb_home.dart';

final class _MiddleTransportInfoCardStatefulView extends StatefulWidget {
  final int index;
  final InfoMiddleTransportCardState cardState;
  final Stream<RealTimeInfo?>? streamRealTimeInfo;

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
    required int? arrivalSec1,
    required int? arrivalSec2,
  }) {
    if (!isFirstStream) {
      return;
    }

    if ((arrivalSec1 == null) || (arrivalSec2 == null)) {
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
          final arrivalSec1 = snapshot.data?.arrivalSec1;
          final arrivalSec2 = snapshot.data?.arrivalSec2;

          _setScaleEffect(
            arrivalSec1: arrivalSec1,
            arrivalSec2: arrivalSec2,
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
                _RightDisPatchColumnContent(
                  index: widget.index,
                  arrivalSec1: arrivalSec1,
                  arrivalSec2: arrivalSec2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
