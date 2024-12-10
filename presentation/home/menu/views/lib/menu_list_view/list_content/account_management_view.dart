part of '../../../eb_menu.dart';

final class _AccountManagementView extends StatelessWidget {
  static const routeName = '_AccountManagementView';

  static MaterialPageRoute route(BuildContext context) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => _AccountManagementView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: _AccountManagementContent(),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        '계정 관리',
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

final class _AccountManagementContent extends StatelessWidget {
  final double fontSize = 20;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _title(),
        _logout(context),
        _row(
          title: '비밀번호 변경',
          onTap: () {
            Navigator.of(context).push(
              _ChangePasswordView.route(context),
            );
          },
        ),
        _row(
          title: '회원 탈퇴',
          onTap: () {
            Navigator.of(context).push(
              _RemoveUserView.route(context),
            );
          },
        ),
      ],
    );
  }

  Widget _title() {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "계정 정보",
        style: TextStyle(
          fontFamily: FontFamily.nanumSquareBold,
          fontSize: 23,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            "아이디",
            style: TextStyle(
              fontFamily: FontFamily.nanumSquareRegular,
              fontSize: fontSize,
              color: EBColors.text,
            ),
          ),
          const SizedBox(width: 10),
          _MyEmailView(fontSize: fontSize),
          const Spacer(),
          TextButton(
            child: Text(
              "로그아웃",
              style: TextStyle(
                fontFamily: FontFamily.nanumSquareRegular,
                fontSize: fontSize,
                color: Colors.grey,
              ),
            ),
            onPressed: () {
              context.read<MenuBloc>().add(PressLogoutButton());
            },
          ),
        ],
      ),
    );
  }

  Widget _row({
    required String title,
    required Function()? onTap,
  }) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: FontFamily.nanumSquareRegular,
                  fontSize: fontSize,
                  color: EBColors.text,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: fontSize,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _MyEmailView extends StatelessWidget {
  final double fontSize;

  const _MyEmailView({
    super.key,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _future(),
      builder: (context, snapshot) {
        return _emailText(snapshot.data ?? '----');
      },
    );
  }

  Future<String> _future() async {
    try {
      final email = await SecureStorage().read(key: SecureStorageKey.email);
      return email;
    } catch (e) {
      log(e.toString());
      return '----';
    }
  }

  Widget _emailText(String email) {
    return Text(
      email,
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareExtraBold,
        color: EBColors.blue3,
        fontSize: fontSize - 3,
      ),
    );
  }
}
