part of '../../eb_root.dart';

final class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingContent(),
    );
  }
}

final class OnboardingContent extends StatelessWidget {
  final images = Assets.images;
  final Color color = EBColors.blue3;
  final double fontSize = 20;

  OnboardingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.8;

    return IntroductionScreen(
      pages: [
        _onboardingImage(image: images.onboarding1, height: height),
        _onboardingImage(image: images.onboarding2, height: height),
        _onboardingImage(image: images.onboarding3, height: height),
      ],
      done: Text("완료", style: _textStyle()),
      onDone: () {
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => const MyPage()));
      },
      next: Icon(
        Icons.arrow_forward,
        color: color,
        size: fontSize,
      ),
      skip: Text("스킵", style: _textStyle()),
      showSkipButton: true,
      curve: Curves.ease,
      dotsDecorator: DotsDecorator(
        activeColor: EBColors.blue3,
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      globalBackgroundColor: Colors.white,
      globalFooter: const SizedBox(
        height: 30,
      ),
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
    );
  }

  PageViewModel _onboardingImage({
    required AssetGenImage image,
    required double height,
  }) {
    return PageViewModel(
      title: "",
      body: "",
      image: image.image(
        width: double.infinity,
        height: height,
        alignment: Alignment.center,
        fit: BoxFit.cover,
      ),
      decoration: const PageDecoration(fullScreen: true, safeArea: 100),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      color: color,
      fontFamily: FontFamily.nanumSquareBold,
      fontSize: fontSize,
    );
  }
}
