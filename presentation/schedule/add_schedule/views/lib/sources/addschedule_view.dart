part of '../eb_add_schedule.dart';

final class AddScheduleView extends StatelessWidget {
  AddScheduleState? state;

  AddScheduleView({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddScheduleBloc(
        addScheduleState: state,
        searchPlaceDelegateForPlace:
            RepositoryProvider.of<SearchPlaceDelegateForPlace>(context),
        searchPlaceDelegateForRoute:
            RepositoryProvider.of<SearchPlaceDelegateForRoute>(context),
        scheduleRepository: RepositoryProvider.of<ScheduleRepository>(context),
      ),
      child: const _AddScheduleContent(),
    );
  }
}

final class _AddScheduleContent extends StatelessWidget {
  final double fontSize = 17;

  const _AddScheduleContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
