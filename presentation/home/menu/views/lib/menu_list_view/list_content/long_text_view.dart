part of '../../../eb_menu.dart';

final class LongTextView extends StatelessWidget {
  final String title;
  final String longText;

  const LongTextView({
    super.key,
    required this.title,
    required this.longText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _longText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _longText() {
    return Container(
      child: Row(
        children: [
          Flexible(
            child: Text(
              longText,
              style: const TextStyle(
                fontFamily: FontFamily.nanumSquareLight,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontFamily: FontFamily.nanumSquareBold,
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
