part of '../../../../eb_menu.dart';

final class _ChangePasswordView extends StatelessWidget {
  static MaterialPageRoute route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => _ChangePasswordView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _ChangePasswordContent(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        '비밀번호 변경',
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

final class _ChangePasswordContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomPadding = ScreenSize.safeArea.bottom(context) + 20;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _title(),
          const SizedBox(height: 10),
          _ChangePasswordInput(),
          _ChangePasswordConfirmInput(),
          const SizedBox(height: 30),
          _description(),
          const Spacer(),
          _ChangePasswordButton(),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text(
      '새로운 비밀번호를 입력해주세요.',
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareBold,
        fontSize: 18,
      ),
    );
  }

  Widget _description() {
    return const Text(
      '안전한 계정 사용을 위해 비밀번호는 주기적으로 변경해주세요.',
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        color: Colors.grey,
        fontSize: 14,
      ),
    );
  }
}
