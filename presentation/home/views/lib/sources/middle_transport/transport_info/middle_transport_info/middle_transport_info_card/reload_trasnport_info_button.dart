part of '../../../../../eb_home.dart';

final class _ReloadTransportInfoCardButton extends StatefulWidget {
  final int index;

  const _ReloadTransportInfoCardButton({
    super.key,
    required this.index,
  });

  @override
  State<StatefulWidget> createState() => _ReloadTransportInfoCardButtonState();
}

final class _ReloadTransportInfoCardButtonState
    extends State<_ReloadTransportInfoCardButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool absorbing = true;

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
    return AbsorbPointer(
      absorbing: !absorbing,
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
        child: Material(
          color: Colors.white,
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () async {
              setState(() {
                absorbing = false;
              });

              _controller.reverse(from: 1.0);
              context
                  .read<MiddleTranportBloc>()
                  .add(PressReloadButton(selectedIndex: widget.index));
              await Future.delayed(const Duration(milliseconds: 1100));

              if (mounted) {
                setState(() {
                  absorbing = true;
                });
              }
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
      ),
    );
  }
}
