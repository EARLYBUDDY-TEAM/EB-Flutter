part of '../eb_search_place.dart';

final class SearchPlaceView extends StatelessWidget {
  SearchPlaceSetting setting;
  SearchPlaceDelegate delegate;
  SearchPlaceState? searchPlaceState;
  Function(Place)? selectAction;
  Function()? cancelAction;

  static const routeName = 'SearchPlaceView';

  SearchPlaceView({
    super.key,
    required this.setting,
    required this.delegate,
    this.searchPlaceState,
    this.selectAction,
    this.cancelAction,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchPlaceBloc(
        searchPlaceRepository:
            RepositoryProvider.of<SearchPlaceRepository>(context),
        searchPlacedelegate: delegate,
        searchPlaceSetting: setting,
        searchPlaceState: searchPlaceState,
        selectAction: selectAction,
        cancelAction: cancelAction,
      ),
      child: const _EBSearchPlaceView(),
    );
  }
}

final class _EBSearchPlaceView extends StatelessWidget {
  const _EBSearchPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SearchPlaceBloc, SearchPlaceState, SearchPlaceSetting>(
      selector: (state) {
        return state.viewState.setting;
      },
      builder: (context, setting) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _SearchPlaceAppBar(
            textTitle: setting == SearchPlaceSetting.start ? '출발 장소' : '장소',
            cancelAction: () =>
                context.read<SearchPlaceBloc>().add(PressCancelButton()),
          ),
          body: _SearchPlaceContent(),
        );
      },
    );
  }
}
