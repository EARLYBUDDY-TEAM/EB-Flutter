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
  final addScheduleDelegate = AddScheduleDelegate();
  final findRouteDelegate = FindRouteDelegate();
  final searchPlaceRepository = SearchPlaceRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: addScheduleDelegate),
        RepositoryProvider.value(value: findRouteDelegate),
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
        findRouteDelegate: RepositoryProvider.of<FindRouteDelegate>(context),
        addScheduleDelegate:
            RepositoryProvider.of<AddScheduleDelegate>(context),
        searchPlaceRepository:
            RepositoryProvider.of<SearchPlaceRepository>(context),
        searchPlaceState: searchPlaceState,
        navigatorOfPopAction: () => Navigator.of(context).pop(),
      ),
      child: const SearchPlaceScaffold(),
    );
  }
}
