part of '../../../../eb_find_route.dart';

final class _OdsayImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Assets.images.odsay.image(
          height: 40,
          fit: BoxFit.fitHeight,
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
