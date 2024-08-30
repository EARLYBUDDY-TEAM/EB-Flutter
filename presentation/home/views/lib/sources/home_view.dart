part of '../eb_home.dart';

final class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const HomeView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        authRepository: RepositoryProvider.of<EBAuthRepository>(context),
        registerDelegate: RepositoryProvider.of<RegisterDelegate>(context),
        loginDelegate: RepositoryProvider.of<LoginDelegate>(context),
      ),
      child: const _EBHomeView(),
    );
  }
}

final class _EBHomeView extends StatelessWidget {
  const _EBHomeView();

  @override
  Widget build(BuildContext context) {
    showReigsterAlert(context);
    showLoginSnackBar(context);

    return Stack(
      children: [
        Container(color: Colors.white),
        const WaveBackground(),
        Scaffold(
          appBar: _HomeAppBar(
            pressMenuButtonAction: () =>
                context.read<HomeBloc>().add(const PressMenuButton()),
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            alignment: Alignment.bottomRight,
            children: [
              const _HomeContent(),
              _ScheduleAddButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddScheduleView(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showReigsterAlert(BuildContext context) {
    final registerDelegate = RepositoryProvider.of<RegisterDelegate>(context);
    if (registerDelegate.isFirstLogin) {
      Future.delayed(const Duration(seconds: 1), () {
        EBAlert.showModalPopup(
          context: context,
          title: '얼리버디 회원이 되신걸 축하합니다.',
          content: '',
          actions: [
            EBAlert.makeAction(
              name: '확인',
              onPressed: () {
                context
                    .read<HomeBloc>()
                    .add(const PressRegisterAlertOkButton());
                Navigator.of(context).pop();
              },
              isDefaultAction: true,
            )
          ],
        );
      });
    }
  }

  void showLoginSnackBar(BuildContext context) {
    final loginDelegate = RepositoryProvider.of<LoginDelegate>(context);
    if (loginDelegate.isSuccess) {
      Future.delayed(const Duration(seconds: 1), () {
        final snackBar = EBSnackBar(text: '로그인에 성공했습니다.');
        ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((_) {
          //ㄷㄹ
        });
      });
    }
  }
}

final class _HomeAppBar extends AppBar {
  final Function() pressMenuButtonAction;

  _HomeAppBar({
    super.key,
    required this.pressMenuButtonAction,
  });

  @override
  Widget? get leading => IconButton(
        onPressed: pressMenuButtonAction,
        icon: const Icon(Icons.menu, color: Colors.white),
      );

  @override
  Color? get backgroundColor => Colors.transparent;
}

final class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const _ScheduleCard(),
          const SizedBox(height: 30),
          const TransportCard(),
          const SizedBox(height: 30),
          _Calendar(),
        ],
      ),
    );
  }
}
