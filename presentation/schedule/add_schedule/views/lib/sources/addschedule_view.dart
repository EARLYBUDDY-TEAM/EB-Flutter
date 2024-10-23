part of '../eb_add_schedule.dart';

final class AddScheduleView extends StatelessWidget {
  final SealedAddScheduleSetting setting;

  const AddScheduleView({
    super.key,
    required this.setting,
  });

  static MaterialPageRoute Function({
    required BuildContext context,
    required Schedule initialSchedule,
  }) get pageChangeAddSchedule {
    return ({
      required BuildContext context,
      required Schedule initialSchedule,
    }) =>
        MaterialPageRoute(
          builder: (context) => AddScheduleView(
            setting: ChangeScheduleSetting(initialSchedule: initialSchedule),
          ),
        );
  }

  static MaterialPageRoute Function({
    required BuildContext context,
  }) get pageInitAddSchedule {
    return ({
      required BuildContext context,
    }) =>
        MaterialPageRoute(
          builder: (context) => AddScheduleView(
            setting: InitScheduleSetting(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AddScheduleBloc(
          loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
          addScheduleDelegate:
              RepositoryProvider.of<AddScheduleDelegate>(context),
          scheduleRepository:
              RepositoryProvider.of<ScheduleRepository>(context),
          tokenEvent: RepositoryProvider.of<TokenEvent>(context),
          cancelModalViewAction: () => Navigator.of(context).pop(),
        )..add(SetupAddScheduleView(setting: setting));
      },
      child: const _AddScheduleContent(),
    );
  }

  static MaterialPageRoute pageFindRoute({
    required Place startPlace,
    required Place endPlace,
  }) {
    return MaterialPageRoute(
      builder: (_) => FindRouteView(
        startPlace: startPlace,
        endPlace: endPlace,
        pageChangeStartPlace: SearchPlaceView.pageChangeStartPlace,
        pageChangeEndPlace: SearchPlaceView.pageChangeEndPlace,
        parentName: '출발 장소',
      ),
    );
  }
}

final class _AddScheduleContent extends StatelessWidget {
  final double fontSize = 17;

  const _AddScheduleContent();

  @override
  Widget build(BuildContext context) {
    final bottomSafe = ScreenSize.safeArea.bottom(context);

    return BlocConsumer<AddScheduleBloc, AddScheduleState>(
      listener: (context, state) {
        showAddScheduleResultAlert(context, state.result);
      },
      buildWhen: (previous, current) {
        return previous.setting != current.setting;
      },
      builder: (context, state) {
        final titleString =
            (state.setting is InitScheduleSetting) ? "일정 등록" : "일정 수정";

        return Scaffold(
          appBar: _AddScheduleAppBar(
            titleString: titleString,
            popViewAction: () => Navigator.of(context).pop(),
            removeScheduleAction: _removeScheduleAction(state.setting),
          ),
          body: SafeArea(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _AddScheduleForms(bottomPadding: bottomSafe + 40 + 20),
                _AddScheduleButton(bottomPadding: bottomSafe),
              ],
            ),
          ),
        );
      },
    );
  }

  Function()? _removeScheduleAction(SealedAddScheduleSetting setting) {
    switch (setting) {
      case InitScheduleSetting():
        return null;
      case ChangeScheduleSetting():
        return () {};
    }
  }

  void showAddScheduleResultAlert(
    BuildContext context,
    BaseStatus result,
  ) {
    if (result == BaseStatus.init) {
      return;
    }

    String title;
    String? content;
    switch (result) {
      case (BaseStatus.success):
        title = "일정을 등록했습니다!";
      default:
        title = "일정등록에 실패했습니다.";
        content = "네트워크 상태를 확인후 다시 시도해주세요.";
    }
    EBAlert.showModalPopup(
      context: context,
      title: title,
      content: content,
      actions: [
        EBAlert.makeAction(
          name: '확인',
          onPressed: () {
            context.read<AddScheduleBloc>().add(const PressAlertOkButton());
            Navigator.of(context).pop();
            if (result == BaseStatus.success) {
              Navigator.of(context).pop();
            }
          },
          isDefaultAction: true,
        )
      ],
    );
  }
}
