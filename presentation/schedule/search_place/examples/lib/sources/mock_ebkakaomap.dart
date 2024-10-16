part of 'searchplace_example.dart';

final class _MockEBKakaoMapView extends StatelessWidget {
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
        backFindRouteViewAction: () => Navigator.of(context).pop(),
        searchPlaceDelegate:
            RepositoryProvider.of<SearchPlaceDelegate>(context),
        addScheduleDelegate:
            RepositoryProvider.of<AddScheduleDelegate>(context),
        searchPlaceRepository:
            RepositoryProvider.of<SearchPlaceRepository>(context),
        searchPlaceState: searchPlaceState,
      ),
      child: EBKakaoMapView(
        place: mockPlace,
      ),
    );
  }
}
