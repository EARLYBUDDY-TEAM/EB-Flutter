part of '../../eb_menu.dart';

final class _HomeMenuListContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _row(
                title: '전체 알림',
                onTap: null,
              ),
            ),
            const _NotificationToggleButton(),
          ],
        ),
        _divider(),
        _row(
          title: '계정 관리',
          onTap: () {
            Navigator.of(context).push(
              _AccountManagementView.route(context),
            );
          },
        ),
        _divider(),
        _row(
          title: '오픈소스 라이선스',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const OpenSourceLicenseView(),
              ),
            );
          },
        ),
        _divider(),
        _row(
          title: '서비스 이용약관',
          onTap: () {},
        ),
        _divider(),
        _row(
          title: '개인정보처리방침',
          onTap: () {},
        ),
        _divider(),
        _row(
          title: '법적 공지 및 정보제공처',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LegalNoticeView(),
              ),
            );
          },
        ),
      ],
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
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: FontFamily.nanumSquareBold,
                  color: EBColors.text,
                  fontSize: 22,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      color: Colors.grey,
      thickness: 0.5,
    );
  }
}
