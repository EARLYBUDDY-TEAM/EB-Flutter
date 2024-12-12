part of '../../../../../eb_home.dart';

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
