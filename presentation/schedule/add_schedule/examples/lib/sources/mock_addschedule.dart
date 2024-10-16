part of 'addschedule_example.dart';

// final class MockAddSchedule extends StatelessWidget {
//   final _loadingDelegate = LoadingDelegate();
//   final _loginDelegate = LoginDelegate();
//   final _rootDelegate = RootDelegate();
//   final _searchPlaceDelegateForPlace = SearchPlaceDelegateForEnd();
//   final _searchPlaceDelegateForRoute = SearchPlaceDelegateForStart();

//   final _scheduleRepository = ScheduleRepository();
//   final _tokenRepository = TokenRepository();

//   late final _tokenEvent = TokenEvent(
//     rootDelegate: _rootDelegate,
//     loginDelegate: _loginDelegate,
//     tokenRepository: _tokenRepository,
//   );

//   late final bloc = AddScheduleBloc(
//     loadingDelegate: _loadingDelegate,
//     searchPlaceDelegateForPlace: _searchPlaceDelegateForPlace,
//     searchPlaceDelegateForRoute: _searchPlaceDelegateForRoute,
//     scheduleRepository: _scheduleRepository,
//     tokenEvent: _tokenEvent,
//   );

//   MockAddSchedule({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiRepositoryProvider(
//       providers: [
//         RepositoryProvider.value(value: _loginDelegate),
//         RepositoryProvider.value(value: _rootDelegate),
//         RepositoryProvider.value(value: _searchPlaceDelegateForPlace),
//         RepositoryProvider.value(value: _searchPlaceDelegateForRoute),
//         RepositoryProvider.value(value: _scheduleRepository),
//         RepositoryProvider.value(value: _tokenRepository),
//       ],
//       child: MaterialApp(
//         home: _NaviButton(
//           toShow: AddScheduleView(bloc: bloc),
//           onPressed: () async {
//             await setAddScheduleResult();
//           },
//         ),
//       ),
//     );
//   }

//   Future<void> setAddScheduleResult() async {
//     await Future<void>.delayed(const Duration(seconds: 2));
//     bloc.add(const SetAddScheduleResult(result: AddScheduleResult.fail));
//   }
// }

// final class _NaviButton extends StatelessWidget {
//   final StatelessWidget toShow;
//   final Function() onPressed;

//   const _NaviButton({
//     required this.toShow,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: TextButton(
//           onPressed: () {
//             onPressed();
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (_) => toShow,
//               ),
//             );
//           },
//           child: const Text('Navi AddScheduleView'),
//         ),
//       ),
//     );
//   }
// }
