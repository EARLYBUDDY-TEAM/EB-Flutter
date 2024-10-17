part of 'searchplace_example.dart';

List<Place> get longTextPlaceList {
  final places = List<Place>.generate(100, (index) => Place.mockView());
  return places;
}

List<Place> get starBucksPlaceList {
  final places = List<Place>.generate(100, (index) => Place.mockStarBucks());
  return places;
}

final class _MockModalSearchPlaceView extends StatelessWidget {
  final searchPlaceDelegate = SearchPlaceDelegate();
  final addScheduleDelegate = AddScheduleDelegate();
  final searchPlaceRepository = SearchPlaceRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: searchPlaceDelegate),
        RepositoryProvider.value(value: addScheduleDelegate),
        RepositoryProvider.value(value: searchPlaceRepository),
      ],
      child: _ModalTextButtonView(),
    );
  }
}

final class _ModalTextButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: TextButton(
              child: const Text('Push SearchPlaceView'),
              onPressed: () => _onPressed(context),
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      expand: true,
      backgroundColor: Colors.white,
      builder: (context) => Material(
        child: Navigator(
          onGenerateRoute: (context) => MaterialPageRoute(
            builder: (context) => Builder(builder: (context) => _mockView),
          ),
        ),
      ),
    );
  }

  _MockSearchPlaceBlocView get _mockView {
    final contentStatus = ListSearchPlaceContent(placeList: starBucksPlaceList);
    final state = SearchPlaceState(
      setting: EndSearchPlaceSetting(),
      contentStatus: contentStatus,
    );
    return _MockSearchPlaceBlocView(searchPlaceState: state);
  }
}

final class _MockSearchPlaceBlocView extends StatelessWidget {
  final SearchPlaceState searchPlaceState;

  const _MockSearchPlaceBlocView({
    super.key,
    required this.searchPlaceState,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchPlaceBloc(
        backFromFindRouteViewAction: () => Navigator.of(context).pop(),
        searchPlaceDelegate:
            RepositoryProvider.of<SearchPlaceDelegate>(context),
        addScheduleDelegate:
            RepositoryProvider.of<AddScheduleDelegate>(context),
        searchPlaceRepository:
            RepositoryProvider.of<SearchPlaceRepository>(context),
        searchPlaceState: searchPlaceState,
      ),
      child: const SearchPlaceScaffold(),
    );
  }
}

// final class SearchPlaceView extends StatelessWidget {
//   final SearchPlaceSetting setting;
//   static const routeName = 'SearchPlaceView';

//   const SearchPlaceView({
//     required this.setting,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SearchPlaceBloc(
//         backFindRouteViewAction: () => Navigator.of(context).pop(),
//         searchPlaceDelegate:
//             RepositoryProvider.of<SearchPlaceDelegate>(context),
//         addScheduleDelegate:
//             RepositoryProvider.of<AddScheduleDelegate>(context),
//         searchPlaceRepository:
//             RepositoryProvider.of<SearchPlaceRepository>(context),
//         searchPlaceState: SearchPlaceState(setting: setting),
//       ),
//       child: const SearchPlaceScaffold(),
//     );
//   }
// }

// final class _MockModalSearchPlaceForRoute extends StatelessWidget {
//   final delegate = SearchPlaceDelegateForRoute();
//   static const routeName = 'MockModalSearchPlaceForRoute';

//   _MockModalSearchPlaceForRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider(
//       create: (context) => delegate,
//       child: MaterialApp(
//         onGenerateRoute: (settings) => MaterialPageRoute(
//           settings: const RouteSettings(name: routeName),
//           builder: (context) => Scaffold(
//             body: Center(
//               child: TextButton(
//                 child: const Text('Push SearchPlaceView'),
//                 onPressed: () => onPressed(context),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void selectAction(
//     BuildContext parent,
//     BuildContext child,
//   ) {
//     final start = Place.mockStart();
//     final end = Place.mockEnd();
//     Navigator.push(
//       child,
//       MaterialPageRoute(
//         builder: (context2) => FindRouteView(
//           start: start,
//           end: end,
//           parentName: '출발 장소',
//           backAction: () => Navigator.of(child).pop(),
//           cancelAction: () => Navigator.of(parent).pop(),
//         ),
//       ),
//     );
//   }

//   void onPressed(BuildContext context) {
//     showCupertinoModalBottomSheet(
//       settings: const RouteSettings(name: SearchPlaceView.routeName),
//       context: context,
//       expand: true,
//       backgroundColor: Colors.white,
//       builder: (context) => Material(
//         child: Navigator(
//           onGenerateRoute: (_) => MaterialPageRoute(
//             builder: (_) => Builder(
//               builder: (context2) => SearchPlaceView(
//                 setting: SearchPlaceSetting.start,
//                 delegate:
//                     RepositoryProvider.of<SearchPlaceDelegateForRoute>(context),
//                 searchPlaceState: SearchPlaceState.mockStarBucks(),
//                 selectAction: (_) => selectAction(context, context2),
//                 cancelAction: () => Navigator.of(context).pop(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
