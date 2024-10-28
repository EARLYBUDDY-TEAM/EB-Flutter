part of 'searchplace_example.dart';

final class _MockEBKakaoContentView extends StatelessWidget {
  final place = Place.mockStarBucks();

  _MockEBKakaoContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: EBKakaoMapContent(
          place: place,
        ),
      ),
    );
  }
}

final class _MockEBKakaoMapView extends StatelessWidget {
  final findRouteDelegate = FindRouteDelegate();
  final addScheduleDelegate = AddScheduleDelegate();
  final searchPlaceRepository = SearchPlaceRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: findRouteDelegate),
        RepositoryProvider.value(value: addScheduleDelegate),
        RepositoryProvider.value(value: searchPlaceRepository),
      ],
      child: MaterialApp(
        home: _MockEBKakaoMapBlocView(),
      ),
    );
  }
}

final class _MockEBKakaoMapBlocView extends StatelessWidget {
  final searchPlaceState = SearchPlaceState(setting: EndSearchPlaceSetting());
  final mockPlace = Place.mockStarBucks();

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
      child: EBKakaoMapView(
        place: mockPlace,
      ),
    );
  }
}
