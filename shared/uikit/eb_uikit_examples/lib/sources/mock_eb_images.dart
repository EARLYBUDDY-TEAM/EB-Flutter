part of 'eb_uikit_example.dart';

final class _MockEBImages extends StatelessWidget {
  const _MockEBImages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TestLoginTitleImage(),
      ),
    );
  }
}

// final class EBImages {
//   static const EBAssetImage splash = EBAssetImage('splash.png');
//   static const EBAssetImage loginTitle = EBAssetImage('login_title.png');
//   static const EBAssetImage markFindRoute = EBAssetImage('mark_findroute.png');
//   static EBAssetImage odsay = const EBAssetImage('odsay.png');
// }

// class EBAssetImage extends AssetImage {
//   const EBAssetImage(String fileName) : super('assets/images/$fileName');
// }

final class TestLoginTitleImage extends StatelessWidget {
  // final image = EBImages.loginTitle;
  // final image =
  //     Image.asset('packages/eb_resources/assets/images/login_title.png');

  const TestLoginTitleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Assets.images.loginTitle.image(
      height: 100,
      fit: BoxFit.fitHeight,
    );

    // return SizedBox(
    //   width: 100,
    //   height: 100,
    //   child: image,
    // );
    // return Container(
    //   height: 50,
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       image: image,
    //       fit: BoxFit.fitHeight,
    //     ),
    //   ),
    // );
  }
}
