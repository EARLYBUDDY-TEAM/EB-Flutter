part of '../eb_home.dart';

final class HomeView extends StatefulWidget {
  static Route<void> route(BuildContext context) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: "HomeView"),
      builder: (context) => const HomeView(),
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
      create: (context) {
        return HomeBloc(
          loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
          homeDelegate: RepositoryProvider.of<HomeDelegate>(context),
          homeRepository: RepositoryProvider.of<HomeRepositoryAB>(context),
          tokenEvent: RepositoryProvider.of<EBTokenEvent>(context),
          scheduleEvent: RepositoryProvider.of<ScheduleEvent>(context),
          cancelModalViewAction: () {
            Navigator.of(context).popUntil(
              (route) => route.settings.name == "HomeView",
            );
          },
        )..add(OnAppearHomeView());
      },
      child: const WithRegisterConfettiView(
        child: EBHomeView(),
      ),
    );
  }
}

final class EBHomeView extends StatelessWidget {
  const EBHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        loginResultSnackBarListener(),
        getAllScheduleCardErrorAlertListener(),
      ],
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(color: Colors.white),
          const WaveBackground(),
          _homeContent(context),
          _addScheduleButton(context),
        ],
      ),
    );
  }

  Widget _addScheduleButton(BuildContext context) {
    return _ScheduleAddButton(
      onPressed: () => Navigator.of(context).push(
        AddScheduleView.pageInitAddSchedule(context: context),
      ),
    );
  }

  Widget _homeContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _HomeAppBar(
        pressMenuButtonAction: () {
          Navigator.of(context).push(
            HomeMenuListView.route(context),
          );
        },
      ),
      body: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _HomeContent(),
      ),
    );
  }
}

extension on EBHomeView {
  BlocListener<HomeBloc, HomeState> loginResultSnackBarListener() {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) {
        final previousLogin = previous.status.login;
        final currentLogin = current.status.login;
        return previousLogin != currentLogin;
      },
      listener: (context, state) async {
        await _showLoginResultSnackBar(context);
      },
    );
  }

  Future<void> _showLoginResultSnackBar(
    BuildContext context,
  ) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final userNickName =
        await context.read<HomeBloc>().getUserNickName ?? '----';

    final snackBar = _makeLoginSnackBar(userNickName);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  SnackBar _makeLoginSnackBar(String userNickName) {
    return SnackBar(
      backgroundColor: EBColors.blue3,
      content: DefaultTextStyle(
        style: const TextStyle(
          fontFamily: FontFamily.nanumSquareExtraBold,
          fontSize: 20,
          color: Colors.white,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  userNickName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Text('님 환영합니다.'),
            ],
          ),
        ),
      ),
    );
  }
}

extension on EBHomeView {
  BlocListener<HomeBloc, HomeState> getAllScheduleCardErrorAlertListener() {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) async {
        await _showGetAllScheduleCardErrorAlert(
          context,
          state.status.getAllScheduleCard,
        );
      },
      listenWhen: (previous, current) {
        return previous.status.getAllScheduleCard !=
            current.status.getAllScheduleCard;
      },
    );
  }

  Future<void> _showGetAllScheduleCardErrorAlert(
    BuildContext context,
    BaseStatus getAllScheduleCardStatus,
  ) async {
    if (getAllScheduleCardStatus != BaseStatus.fail) {
      return;
    }

    await Future<void>.delayed(const Duration(seconds: 1));

    EBAlert.showModalPopup(
      context: context,
      title: '일정 정보를 가져오는데 실패했습니다.',
      content: '네트워크 상태를 확인해주세요.',
      actions: [
        EBAlert.makeAction(
          name: '확인',
          onPressed: () {
            context
                .read<HomeBloc>()
                .add(SetHomeStatus(getAllScheduleCard: BaseStatus.init));
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
        )
      ],
    );
  }
}
