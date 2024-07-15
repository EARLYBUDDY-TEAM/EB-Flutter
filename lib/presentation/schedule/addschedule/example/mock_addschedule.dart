part of 'addschedule_example.dart';

final class MockAddSchedule extends StatelessWidget {
  final _searchPlaceDelegateForPlace = SearchPlaceDelegateForPlace();
  final _searchPlaceDelegateForRoute = SearchPlaceDelegateForRoute();

  MockAddSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _searchPlaceDelegateForPlace),
        RepositoryProvider.value(value: _searchPlaceDelegateForRoute),
      ],
      child: MaterialApp(
        home: _MyMockAddSchedule(),
      ),
    );
  }
}

final class _MyMockAddSchedule extends StatelessWidget {
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
