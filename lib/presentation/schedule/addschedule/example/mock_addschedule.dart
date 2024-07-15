part of 'addschedule_example.dart';

final class _MockAddSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddScheduleBloc(
        searchPlaceDelegateForPlace:
            RepositoryProvider.of<SearchPlaceDelegateForPlace>(context),
        searchPlaceDelegateForRoute:
            RepositoryProvider.of<SearchPlaceDelegateForRoute>(context),
      ),
      child: const AddScheduleView(),
    );
  }
}
