part of 'home_view.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({super.key});

  @override
  Widget? get leading => _MenuButton();

  @override
  Color? get backgroundColor => Colors.transparent;
}

class _MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<HomeBloc>().add(const HomeMenuPressed());
      },
      icon: const Icon(Icons.menu, color: Colors.white),
    );
  }
}
