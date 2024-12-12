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
            RegisterConfettiView(
              nickName: nickName,
            ),
          ]
        : [child];
  }
}

final class RegisterConfettiView extends StatelessWidget {
  final String _nickName;

  RegisterConfettiView({
    super.key,
    required String nickName,
  }) : _nickName = nickName.isEmpty ? '----' : nickName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          color: Colors.black12.withOpacity(.3),
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
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _nickName,
                style: const TextStyle(
                  fontFamily: FontFamily.nanumSquareBold,
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              EBButton(
                name: '확인',
                onPressed: () {
                  context.read<HomeBloc>().add(PressRegisterConfirmButton());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
