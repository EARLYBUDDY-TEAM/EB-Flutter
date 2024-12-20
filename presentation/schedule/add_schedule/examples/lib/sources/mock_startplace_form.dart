part of 'addschedule_example.dart';

final class MockAddScheduleBlocView extends StatelessWidget {
  final pathInfo = PathState(
    startPlace: Place.mockStart(),
    endPlace: Place.mockEnd(),
    transportLineOfPath: TransportLineOfPath.mock(),
    ebPath: EBPath.mock(),
  );

  MockAddScheduleBlocView({super.key});

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
          tokenEvent: RepositoryProvider.of<EBTokenEvent>(context),
          cancelModalViewAction: () => Navigator.of(context).pop(),
          addScheduleState: AddScheduleState(
            startPlaceState: SelectedStartPlaceState(
              pathInfo: pathInfo,
            ),
          ),
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
