part of '../../eb_home.dart';

final class HomeMenuListView extends StatelessWidget {
  const HomeMenuListView({super.key});

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => const HomeMenuListView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: _HomeMenuListContent(),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        '설정',
        style: TextStyle(
          fontFamily: FontFamily.nanumSquareBold,
          fontSize: 18,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}
