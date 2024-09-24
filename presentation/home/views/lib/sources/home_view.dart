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
      create: (_) => HomeBloc(
        homeDelegate: RepositoryProvider.of<HomeDelegate>(context),
      ),
      child: const _EBHomeView(),
    );
  }
}

final class _EBHomeView extends StatelessWidget {
  const _EBHomeView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) async {
        await showLoginResultSnackBar(
          context,
          state.loginStatus,
        );

        await showReigsterResultAlert(
          context,
          state.registerStatus,
        );
      },
      child: Stack(
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
      ),
    );
  }

  Future<void> showReigsterResultAlert(
    BuildContext context,
    BaseStatus registerStatus,
  ) async {
    if (registerStatus != BaseStatus.success) {
      return;
    }

    await Future<void>.delayed(const Duration(seconds: 1));

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
                .add(const SetRegisterStatus(status: BaseStatus.init));
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
        )
      ],
    );
  }

  Future<void> showLoginResultSnackBar(
    BuildContext context,
    BaseStatus loginStatus,
  ) async {
    if (loginStatus != BaseStatus.success) {
      return;
    }

    await Future<void>.delayed(const Duration(seconds: 1));

    final snackBar = EBSnackBar(text: '로그인에 성공했습니다.');
    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((_) {
      context
          .read<HomeBloc>()
          .add(const SetLoginStatus(status: BaseStatus.init));
    });
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
