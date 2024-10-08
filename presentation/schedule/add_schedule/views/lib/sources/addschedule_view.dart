part of '../eb_add_schedule.dart';

final class AddScheduleView extends StatelessWidget {
  AddScheduleBloc? bloc;

  AddScheduleView({super.key, this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return bloc ??
            AddScheduleBloc(
              loadingDelegate: RepositoryProvider.of<LoadingDelegate>(context),
              searchPlaceDelegateForPlace:
                  RepositoryProvider.of<SearchPlaceDelegateForPlace>(context),
              searchPlaceDelegateForRoute:
                  RepositoryProvider.of<SearchPlaceDelegateForRoute>(context),
              scheduleRepository:
                  RepositoryProvider.of<ScheduleRepository>(context),
              tokenEvent: TokenEvent(
                rootDelegate: RepositoryProvider.of<RootDelegate>(context),
                loginDelegate: RepositoryProvider.of<LoginDelegate>(context),
                tokenRepository:
                    RepositoryProvider.of<TokenRepository>(context),
              ),
            );
      },
      child: const _AddScheduleContent(),
    );
  }
}

final class _AddScheduleContent extends StatelessWidget {
  final double fontSize = 17;

  const _AddScheduleContent();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddScheduleBloc, AddScheduleState>(
      listener: (context, state) {
        showAddScheduleResultAlert(context, state.result);
      },
      child: Scaffold(
        appBar: _AppBar(context: context),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _AddScheduleForms(),
              _AddScheduleButton(),
            ],
          ),
        ),
      ),
    );
  }

  void showAddScheduleResultAlert(
    BuildContext context,
    AddScheduleResult result,
  ) {
    if (result == AddScheduleResult.init) {
      return;
    }

    String title;
    String? content;
    switch (result) {
      case (AddScheduleResult.success):
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
            if (result == AddScheduleResult.success) {
              Navigator.of(context).pop();
            }
          },
          isDefaultAction: true,
        )
      ],
    );
  }
}
