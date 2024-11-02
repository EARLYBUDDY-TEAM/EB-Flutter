part of '../../../eb_home.dart';

final class _ReloadTransportInfoButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReloadTransportInfoButtonState();
}

final class _ReloadTransportInfoButtonState extends State
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
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () async {
            _controller.reverse(from: 1.0);
          },
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
        ),
      ),
    );
  }
}
