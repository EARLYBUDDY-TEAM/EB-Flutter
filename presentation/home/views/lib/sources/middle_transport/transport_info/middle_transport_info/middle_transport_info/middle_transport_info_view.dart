part of '../../../../../eb_home.dart';

final class MiddleTransportInfoView extends StatelessWidget {
  final int currentIndex;
  final List<InfoMiddleTransportCardState> cardStateList;
  final StreamRealTimeInfo? streamRealTimeInfo;
  final double horizontalPadding;

  const MiddleTransportInfoView({
    super.key,
    required this.currentIndex,
    required this.cardStateList,
    required this.streamRealTimeInfo,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SnapCardView(
      cardCount: cardStateList.length,
      listHorizontalPadding: horizontalPadding,
      cardSpacing: 3,
      initialIndex: currentIndex,
      onChangeIndex: (index) => _onChangeIndex(
        context: context,
        index: index,
      ),
      itemBuilder: _itemBuilder,
    );
  }

  void _onChangeIndex({
    required BuildContext context,
    required int index,
  }) {
    context.read<MiddleTranportBloc>().add(
          ChangeTransportInfoCard(expectIndex: index),
        );
  }

  Widget? Function(BuildContext, int) _itemBuilder({
    required double cardWidth,
  }) {
    return (context, index) {
      final newStreamRealTimeInfo =
          (currentIndex == index) ? streamRealTimeInfo : null;
      final cardState = cardStateList[index];

      return _MiddleTransportInfoCard(
        myIndex: index,
        cardWidth: cardWidth,
        cardState: cardState,
        streamBusRealTimeInfo: newStreamRealTimeInfo,
      );

      // return Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 20),
      //   child: SizedBox(
      //     width: cardWidth,
      //     child: _MiddleTransportInfoCardStatefulView(
      //       myIndex: index,
      //       cardState: cardStateList[index],
      //       streamBusRealTimeInfo: newStreamRealTimeInfo,
      //     ),
      //   ),
      // );
    };
  }
}

final class _MiddleTransportInfoCard extends StatefulWidget {
  final int myIndex;
  final double cardWidth;
  final InfoMiddleTransportCardState cardState;
  final StreamRealTimeInfo? streamBusRealTimeInfo;

  const _MiddleTransportInfoCard({
    super.key,
    required this.cardWidth,
    required this.cardState,
    required this.streamBusRealTimeInfo,
    required this.myIndex,
  });

  @override
  State<StatefulWidget> createState() => _MiddleTransportInfoCardState();
}

final class _MiddleTransportInfoCardState
    extends State<_MiddleTransportInfoCard> {
  bool scaleTrigger = false;

  @override
  void didUpdateWidget(covariant _MiddleTransportInfoCard oldWidget) {
    (widget.streamBusRealTimeInfo == null) ? _downScale() : _upScale();
    super.didUpdateWidget(oldWidget);
  }

  void _upScale() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        scaleTrigger = true;
      }),
    );
  }

  void _downScale() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        scaleTrigger = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _MiddleTransportCardWithScale(
      cardWidth: widget.cardWidth,
      scaleTrigger: scaleTrigger,
      child: StreamBuilder(
        stream: widget.streamBusRealTimeInfo,
        builder: (context, snapshot) {
          final realTimeInfoList = snapshot.data;

          _setScaleEffect(
            realTimeInfoList: realTimeInfoList,
          );

          final curRealTimeInfo = _getRealTimeInfo(
            realTimeInfoList: realTimeInfoList,
          );

          return _middleTransportInfoCardContent(
            realTimeInfoList: realTimeInfoList,
            curRealTimeInfo: curRealTimeInfo,
          );
        },
      ),
    );
  }

  _setScaleEffect({
    required List<RealTimeInfo>? realTimeInfoList,
  }) {
    if ((realTimeInfoList == null) || (realTimeInfoList.isEmpty)) {
      _downScale();
    } else {
      _upScale();
    }

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     _scale = _maxScale;
    //   });
    // });
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
              selectedTransport: widget.cardState.selectedTransport,
              transportSubPath: widget.cardState.subPath,
              expectTotalMinute: widget.cardState.expectTotalMinute,
              myIndex: widget.myIndex,
              realTimeInfoList: realTimeInfoList,
            ),
          ),
          const SizedBox(width: 4),
          _RightDisPatchColumn(
            index: widget.myIndex,
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

    final selectedTransport = widget.cardState.selectedTransport;
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

final class _MiddleTransportCardWithScale extends StatefulWidget {
  final bool scaleTrigger;
  final double cardWidth;
  final Widget child;

  const _MiddleTransportCardWithScale({
    super.key,
    required this.cardWidth,
    required this.child,
    required this.scaleTrigger,
  });

  @override
  State<StatefulWidget> createState() => _MiddleTransportCardWithScaleState();
}

final class _MiddleTransportCardWithScaleState
    extends State<_MiddleTransportCardWithScale> {
  final double _maxScale = 1.0;
  final double _minScale = 0.95;

  late double _scale;

  @override
  void didUpdateWidget(covariant _MiddleTransportCardWithScale oldWidget) {
    (widget.scaleTrigger) ? _upScale() : _downScale();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _scale = _minScale;
    super.initState();
  }

  void _upScale() {
    if (_scale != _maxScale) {
      setState(() {
        _scale = _maxScale;
      });
    }
  }

  void _downScale() {
    if (_scale != _minScale) {
      setState(() {
        _scale = _minScale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: widget.cardWidth,
        child: AnimatedScale(
          scale: _scale,
          curve: Curves.easeOutQuart,
          duration: const Duration(milliseconds: 450),
          child: widget.child,
        ),
      ),
    );
  }
}
