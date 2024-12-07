part of '../../eb_home.dart';

final class _HomeAppBar extends AppBar {
  final Function() pressMenuButtonAction;

  _HomeAppBar({
    super.key,
    required this.pressMenuButtonAction,
  });

  @override
  Widget? get leading => IconButton(
        onPressed: pressMenuButtonAction,
        icon: const Icon(Icons.menu, color: Colors.white),
      );

  @override
  Color? get backgroundColor => Colors.transparent;

  @override
  Color? get surfaceTintColor => Colors.transparent;

  @override
  double? get elevation => 0.0;
}
