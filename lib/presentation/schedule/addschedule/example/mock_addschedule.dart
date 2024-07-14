part of 'addschedule_example.dart';

final class _MockAddSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddScheduleBloc(
        searchPlaceDelegate:
            RepositoryProvider.of<SearchPlaceDelegate>(context),
      ),
      child: const AddScheduleView(),
    );
  }
}
