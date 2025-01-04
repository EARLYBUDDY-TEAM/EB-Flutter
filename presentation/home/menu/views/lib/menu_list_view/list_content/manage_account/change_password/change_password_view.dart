part of '../../../../../eb_menu.dart';

final class _ChangePasswordView extends StatelessWidget {
  static MaterialPageRoute route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => _ChangePasswordView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        _successChangePasswordListener(),
        _failChangePasswordListener(),
      ],
      child: Scaffold(
        appBar: _appBar(context),
        body: _ChangePasswordContent(),
      ),
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

extension on _ChangePasswordView {
  BlocListener<MenuBloc, MenuState> _successChangePasswordListener() {
    return BlocListener<MenuBloc, MenuState>(
      listenWhen: (previous, current) {
        final flag1 = previous.menuViewStatus.changePasswordStatus !=
            current.menuViewStatus.changePasswordStatus;
        final flag2 =
            current.menuViewStatus.changePasswordStatus == BaseStatus.success;
        return flag1 && flag2;
      },
      listener: (context, state) {
        Navigator.of(context).push(
          CompleteChangePasswordView.route(context),
        );
        context.read<MenuBloc>().add(
              SetMenuViewStatus(
                changePasswordStatus: BaseStatus.init,
              ),
            );
      },
    );
  }
}

extension on _ChangePasswordView {
  BlocListener<MenuBloc, MenuState> _failChangePasswordListener() {
    return BlocListener<MenuBloc, MenuState>(
      listenWhen: (previous, current) {
        final flag1 = previous.menuViewStatus.changePasswordStatus !=
            current.menuViewStatus.changePasswordStatus;
        final flag2 =
            current.menuViewStatus.changePasswordStatus == BaseStatus.fail;
        return flag1 && flag2;
      },
      listener: (context, state) async {
        await EBAlert.showModalPopup(
          context: context,
          title: '비밀번호 변경에 실패했습니다.',
          content: '네트워크 연결상태를 확인해주세요.',
          actions: [
            EBAlert.makeAction(
              name: '확인',
              onPressed: () {
                context.read<MenuBloc>().add(
                      SetMenuViewStatus(
                        changePasswordStatus: BaseStatus.init,
                      ),
                    );
                Navigator.of(context).pop();
              },
              isDefaultAction: true,
            )
          ],
        );
      },
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
          const SizedBox(height: 20),
          _title(),
          const SizedBox(height: 30),
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
