part of '../../eb_root.dart';

final class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: EBTheme().light(),
      home: OnboardingContent(),
    );
  }
}

final class OnboardingContent extends StatelessWidget {
  final images = Assets.images;
  final dotColor = EBColors.blue3;
  final iconColor = EBColors.blue2;

  OnboardingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenSize.height(context);
    final imageHeight = screenHeight * 0.8;
    final restHeight = screenHeight - imageHeight;
    final safeAreaBottom = ScreenSize.safeArea.bottom(context);
    final bottomIndicatorHeight = restHeight + safeAreaBottom;
    final bottomPadding = bottomIndicatorHeight / 3;

    return IntroductionScreen(
      pages: [
        _onboardingImage(image: images.onboarding1, height: imageHeight),
        _onboardingImage(image: images.onboarding2, height: imageHeight),
        _onboardingImage(image: images.onboarding3, height: imageHeight),
      ],
      done: Text("완료", style: _textStyle()),
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => RootView(),
          ),
        );
      },
      next: Icon(
        Icons.arrow_forward,
        color: iconColor,
        size: 25,
      ),
      skip: Text("스킵", style: _textStyle()),
      showSkipButton: true,
      curve: Curves.ease,
      dotsDecorator: DotsDecorator(
        activeColor: dotColor,
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      globalBackgroundColor: Colors.white,
      controlsPadding: EdgeInsets.only(bottom: bottomPadding),
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
      decoration: const PageDecoration(
        fullScreen: true,
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      color: iconColor,
      fontFamily: FontFamily.nanumSquareBold,
      fontSize: 20,
    );
  }
}
