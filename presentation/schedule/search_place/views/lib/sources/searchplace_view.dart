part of '../eb_search_place.dart';

final class SearchPlaceView extends StatelessWidget {
  final SearchPlaceSetting setting;
  static const routeName = 'SearchPlaceView';

  const SearchPlaceView({
    required this.setting,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchPlaceBloc(
        addScheduleDelegate:
            RepositoryProvider.of<AddScheduleDelegate>(context),
        searchPlaceRepository:
            RepositoryProvider.of<SearchPlaceRepository>(context),
        searchPlaceState: SearchPlaceState(setting: setting),
      ),
      child: const SearchPlaceScaffold(),
    );
  }
}

final class SearchPlaceScaffold extends StatelessWidget {
  const SearchPlaceScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final setting = context.read<SearchPlaceBloc>().state.setting;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _SearchPlaceAppBar(
        textTitle: setting == EndSearchPlaceSetting() ? '장소' : '출발 장소',
        cancelAction: () =>
            context.read<SearchPlaceBloc>().add(PressCancelButton()),
      ),
      body: _SearchPlaceContent(),
    );
  }
}
