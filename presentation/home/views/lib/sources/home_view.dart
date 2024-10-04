part of '../eb_home.dart';

final class HomeView extends StatefulWidget {
  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const HomeView(),
    );
  }

  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

final class _HomeViewState extends State<HomeView> {
  _HomeViewState();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
        homeDelegate: RepositoryProvider.of<HomeDelegate>(context),
        homeRepository: RepositoryProvider.of<HomeRepository>(context),
        tokenEvent: RepositoryProvider.of<TokenEvent>(context),
      )..add(const OnAppearHomeView()),
      child: const EBHomeView(),
    );
  }
}

final class EBHomeView extends StatelessWidget {
  const EBHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) async {
            await showLoginResultSnackBar(context, state.loginStatus);
          },
          listenWhen: (previous, current) {
            return previous.loginStatus != current.loginStatus;
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) async {
            await showReigsterResultAlert(context, state.registerStatus);
          },
          listenWhen: (previous, current) {
            return previous.registerStatus != previous.loginStatus;
          },
        ),
      ],
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(color: Colors.white),
          const WaveBackground(),
          _homeContent(),
          _addScheduleButton(context),
        ],
      ),
    );
  }

  Widget _addScheduleButton(BuildContext context) {
    return _ScheduleAddButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AddScheduleView(),
        ),
      ),
    );
  }

  Widget _homeContent() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _HomeAppBar(
        pressMenuButtonAction: () {},
      ),
      body: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _HomeContent(),
      ),
    );
  }
}

extension on EBHomeView {
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
}

extension on EBHomeView {
  Future<void> showLoginResultSnackBar(
    BuildContext context,
    BaseStatus loginStatus,
  ) async {
    log("showLoginResultSnackBar, loginStatus : ${loginStatus.toString()}");

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
