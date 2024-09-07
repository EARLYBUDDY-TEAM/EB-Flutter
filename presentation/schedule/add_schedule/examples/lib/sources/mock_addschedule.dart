part of 'addschedule_example.dart';

final class MockAddSchedule extends StatelessWidget {
  final _searchPlaceDelegateForPlace = SearchPlaceDelegateForPlace();
  final _searchPlaceDelegateForRoute = SearchPlaceDelegateForRoute();
  final _scheduleRepository = ScheduleRepository();
  late final bloc = AddScheduleBloc(
    searchPlaceDelegateForPlace: _searchPlaceDelegateForPlace,
    searchPlaceDelegateForRoute: _searchPlaceDelegateForRoute,
    scheduleRepository: _scheduleRepository,
  );

  MockAddSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _searchPlaceDelegateForPlace),
        RepositoryProvider.value(value: _searchPlaceDelegateForRoute),
        RepositoryProvider.value(value: _scheduleRepository),
      ],
      child: MaterialApp(
          // home: _MyMockAddSchedule(),
          home: AddScheduleView(bloc: bloc)),
    );
  }

  // Future<void> setAddScheduleResult() async {
  //   await Future<void>.delayed(const Duration(seconds: 5));
  //   bloc.add(const SetAddScheduleResult(result: AddScheduleResult.fail));
  // }
}

// final class _MyMockAddSchedule extends StatelessWidget {
//   final addScheduleState = AddScheduleState(
//     info: ScheduleInfo(
//       endPlace: Place.mockStarBucks(),
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return AddScheduleView(
//       state: addScheduleState,
//     );
//   }
// }
