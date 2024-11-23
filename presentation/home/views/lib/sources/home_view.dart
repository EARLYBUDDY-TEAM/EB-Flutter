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
          tokenEvent: RepositoryProvider.of<TokenEvent>(context),
          scheduleEvent: RepositoryProvider.of<ScheduleEvent>(context),
          notificationEvent: RepositoryProvider.of<NotificationEvent>(context),
          cancelModalViewAction: () {
            Navigator.of(context).popUntil(
              (route) => route.settings.name == "HomeView",
            );
          },
        )..add(OnAppearHomeView());
      },
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
        loginResultSnackBarListener(),
        registerResultAlertListener(),
        getAllScheduleCardErrorAlertListener(),
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
        // onPressed: () => Navigator.of(context).push(
        //   AddScheduleView.pageInitAddSchedule(context: context),
        // ),
        onPressed: () async {
      // await RepositoryProvider.of<NotificationEvent>(context).show();
    });
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
  BlocListener<HomeBloc, HomeState> registerResultAlertListener() {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) async {
        await _showReigsterResultAlert(
          context,
          state.status.register,
        );
      },
      listenWhen: (previous, current) {
        return previous.status.register != current.status.register;
      },
    );
  }

  Future<void> _showReigsterResultAlert(
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
                .add(SetHomeStatus(register: BaseStatus.init));
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
        )
      ],
    );
  }
}

extension on EBHomeView {
  BlocListener<HomeBloc, HomeState> loginResultSnackBarListener() {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) async {
        await _showLoginResultSnackBar(context, state.status.login);
      },
      listenWhen: (previous, current) {
        return previous.status.login != current.status.login;
      },
    );
  }

  Future<void> _showLoginResultSnackBar(
    BuildContext context,
    BaseStatus loginStatus,
  ) async {
    if (loginStatus != BaseStatus.success) {
      return;
    }

    await Future<void>.delayed(const Duration(seconds: 1));

    final snackBar = EBSnackBar(text: '로그인에 성공했습니다.');
    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((_) {
      context.read<HomeBloc>().add(SetHomeStatus(login: BaseStatus.init));
    });
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
