part of 'eb_uikit_example.dart';

class _MockEBRoundedButton extends StatelessWidget {
  const _MockEBRoundedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EBRoundedButton(
          text: 'testest',
          height: 20,
          onPressed: () {
            log('onPressed!');
          },
        ),
      ),
    );
  }
}
