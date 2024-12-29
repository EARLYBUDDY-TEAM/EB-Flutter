part of '../../../../../eb_menu.dart';

final class CompleteChangePasswordView extends StatelessWidget {
  const CompleteChangePasswordView({super.key});

  static MaterialPageRoute route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => const CompleteChangePasswordView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _CompleteChangePasswordContent(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).popUntil(
            (route) => route.settings.name == _AccountManagementView.routeName,
          );
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}

final class _CompleteChangePasswordContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomPadding = ScreenSize.safeArea.bottom(context) + 20;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Assets.lotties.check.lottie(
            width: 150,
            height: 150,
            repeat: false,
            frameRate: FrameRate.max,
          ),
          const SizedBox(height: 50),
          const Text(
            '비밀번호가 변경되었어요!',
            style: TextStyle(
              fontFamily: FontFamily.nanumSquareBold,
              fontSize: 25,
            ),
          ),
          const Spacer(),
          const SizedBox(height: 50),
          const _CompleteChangePasswordButton(),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}

final class _CompleteChangePasswordButton extends StatelessWidget {
  const _CompleteChangePasswordButton();

  @override
  Widget build(BuildContext context) {
    return EBButton(
      name: '확인',
      onPressed: () {
        Navigator.of(context).popUntil(
          (route) => route.settings.name == _AccountManagementView.routeName,
        );
      },
    );
  }
}
