part of 'searchplace_example.dart';

// final class _MockSearchPlace extends StatelessWidget {
//   final searchPlaceRepository = SearchPlaceRepository();
//   final searchPlaceDelegateForPlace = SearchPlaceDelegateForEnd();
//   final searchPlaceDelegateForRoute = SearchPlaceDelegateForStart();

//   _MockSearchPlace({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiRepositoryProvider(
//       providers: [
//         RepositoryProvider.value(value: searchPlaceRepository),
//         RepositoryProvider.value(value: searchPlaceDelegateForPlace),
//         RepositoryProvider.value(value: searchPlaceDelegateForRoute),
//       ],
//       child: MaterialApp(
//         home: _MockSearchPlaceView(),
//       ),
//     );
//   }
// }

// final class _MockSearchPlaceView extends StatelessWidget {
//   final setting = SearchPlaceSetting.end;

//   List<Place> mockView() {
//     final places = List<Place>.generate(100, (index) => Place.mockView());
//     return places;
//   }

//   List<Place> mockStarBucks() {
//     final places = List<Place>.generate(100, (index) => Place.mockStarBucks());
//     return places;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final searchPlacedelegate = setting == SearchPlaceSetting.end
//         ? RepositoryProvider.of<SearchPlaceDelegateForEnd>(context)
//         : RepositoryProvider.of<SearchPlaceDelegateForStart>(context);

//     return BlocProvider(
//       create: (context) => SearchPlaceBloc(
//         searchPlaceState: SearchPlaceState(
//           setting: setting,
//           places: mockView(),
//         ),
//         searchPlaceRepository:
//             RepositoryProvider.of<SearchPlaceRepository>(context),
//         searchPlacedelegate: searchPlacedelegate,
//       ),
//       child: const SearchPlaceScaffold(),
//     );
//   }
// }
