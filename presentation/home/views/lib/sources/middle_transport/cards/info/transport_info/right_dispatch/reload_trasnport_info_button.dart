part of '../../../../../../eb_home.dart';

final class _ReloadIconTransportInfoCard extends StatefulWidget {
  final RealTimeInfo? realTimeInfo;

  const _ReloadIconTransportInfoCard({
    super.key,
    required this.realTimeInfo,
  });

  @override
  State<StatefulWidget> createState() => _ReloadIconTransportInfoCardState();
}

final class _ReloadIconTransportInfoCardState
    extends State<_ReloadIconTransportInfoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _ReloadIconTransportInfoCard oldWidget) {
    if (widget.realTimeInfo != null) {
      _startAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _startAnimation() {
    setState(() {
      _controller.reverse(from: 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Container(
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
        child: const Icon(
          Icons.replay_outlined,
          color: Colors.grey,
        ),
      ),
    );
  }
}
