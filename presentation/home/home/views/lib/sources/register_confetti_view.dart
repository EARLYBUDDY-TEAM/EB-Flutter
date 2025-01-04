part of '../eb_home.dart';

final class WithRegisterConfettiView extends StatelessWidget {
  final Widget child;

  const WithRegisterConfettiView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, String?>(
      selector: (state) => state.status.register,
      builder: (context, nickName) {
        return Stack(
          alignment: Alignment.center,
          children: _children(nickName),
        );
      },
    );
  }

  List<Widget> _children(String? nickName) {
    return (nickName != null)
        ? [
            child,
            RegisterConfettiBackgroundView(
              nickName: nickName,
            ),
          ]
        : [child];
  }
}

final class RegisterConfettiBackgroundView extends StatelessWidget {
  final String nickName;

  const RegisterConfettiBackgroundView({
    super.key,
    required this.nickName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            color: Colors.black12.withOpacity(.7),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Assets.lotties.confetti.lottie(
              repeat: false,
              frameRate: FrameRate.max,
              fit: BoxFit.cover,
            ),
          ),
          RegisterConfettiContent(
            nickName: nickName,
          ),
        ],
      ),
    );
  }
}

final class RegisterConfettiContent extends StatelessWidget {
  final String nickName;

  RegisterConfettiContent({
    super.key,
    required String nickName,
  }) : nickName = nickName.isEmpty ? '----' : nickName;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        fontFamily: FontFamily.gmarketSansRegular,
        color: Colors.white,
        fontSize: 40,
        overflow: TextOverflow.ellipsis,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _nickNameText(),
            const SizedBox(height: 50),
            _celebrationText(),
            const SizedBox(height: 50),
            _okButton(
              onPressed: () {
                context.read<HomeBloc>().add(PressRegisterConfirmButton());
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _nickNameText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            nickName,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Text("님"),
      ],
    );
  }

  Widget _celebrationText() {
    return const DefaultTextStyle(
      style: TextStyle(
        fontFamily: FontFamily.gmarketSansLight,
        color: Colors.white,
        fontSize: 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("얼리버디 회원이"),
          SizedBox(height: 10),
          Text("되신걸 축하합니다! 🎉"),
        ],
      ),
    );
  }

  Widget _okButton({
    required Function()? onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: EBColors.blue3,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontFamily: FontFamily.nanumSquareBold,
          fontSize: 25,
        ),
      ),
      child: const Text("확인"),
    );
  }
}
