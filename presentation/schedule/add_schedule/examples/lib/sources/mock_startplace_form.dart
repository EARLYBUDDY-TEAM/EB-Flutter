part of 'addschedule_example.dart';

final class MockAddScheduleBlocView extends StatelessWidget {
  const MockAddScheduleBlocView({super.key});

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
          addScheduleState:
              AddScheduleState(startPlaceState: SelectedStartPlaceState()),
        );
      },
      child: const MockStartPlaceForm(),
    );
  }
}

final class MockStartPlaceForm extends StatelessWidget {
  const MockStartPlaceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StartPlaceForm(fontSize: 20),
      ],
    ));
  }
}
