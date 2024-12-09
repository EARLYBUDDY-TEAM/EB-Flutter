part of '../../../eb_menu.dart';

final class _RemoveUserView extends StatelessWidget {
  static MaterialPageRoute route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => _RemoveUserView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: const _RemoveUserContent(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}

final class _RemoveUserContent extends StatelessWidget {
  const _RemoveUserContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 50),
          _title(),
          const SizedBox(height: 30),
          _description(),
          const Spacer(),
          _cancelButton(context),
          const SizedBox(height: 20),
          _removeUserButton(),
          const Spacer(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text(
      '정말로 탈퇴하실건가요?',
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareExtraBold,
        fontSize: 25,
      ),
    );
  }

  Widget _description() {
    return const DefaultTextStyle(
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        fontSize: 20,
        color: Colors.grey,
      ),
      child: Column(
        children: [
          Text('회원님의 활동내역이 모두 삭제되고'),
          SizedBox(height: 10),
          Text('삭제된 정보는 돌아오지 않습니다.'),
        ],
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return EBButton(
      name: '돌아가기',
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget _removeUserButton() {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        child: const SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '탈퇴하기',
                  style: TextStyle(
                    fontFamily: FontFamily.nanumSquareBold,
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
