part of '../eb_search_place.dart';

final class SearchPlaceView extends StatelessWidget {
  final SearchPlaceSetting setting;

  static MaterialPageRoute Function({
    required BuildContext context,
    required StartSearchPlaceSetting setting,
  }) get pageStartSearchPlace {
    return ({
      required BuildContext context,
      required StartSearchPlaceSetting setting,
    }) =>
        MaterialPageRoute(
          builder: (context) => SearchPlaceView(
            setting: setting,
          ),
        );
  }

  static MaterialPageRoute Function(BuildContext) get pageEndSearchPlace {
    return (BuildContext context) => MaterialPageRoute(
          builder: (context) => SearchPlaceView(
            setting: EndSearchPlaceSetting(),
          ),
        );
  }

  static MaterialPageRoute Function(BuildContext) get pageChangeStartPlace {
    return (BuildContext context) => MaterialPageRoute(
          builder: (context) => SearchPlaceView(
            setting: ChangeStartSearchPlaceSetting(),
          ),
        );
  }

  static MaterialPageRoute Function(BuildContext) get pageChangeEndPlace {
    return (BuildContext context) => MaterialPageRoute(
          builder: (context) => SearchPlaceView(
            setting: ChangeEndSearchPlaceSetting(),
          ),
        );
  }

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
        findRouteDelegate: RepositoryProvider.of<FindRouteDelegate>(context),
        searchPlaceRepository:
            RepositoryProvider.of<SearchPlaceRepository>(context),
        searchPlaceState: SearchPlaceState(setting: setting),
        navigatorOfPopAction: () => Navigator.of(context).pop(),
      ),
      child: const SearchPlaceScaffold(),
    );
  }
}

final class SearchPlaceScaffold extends StatelessWidget {
  const SearchPlaceScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPlaceBloc, SearchPlaceState>(
      buildWhen: (previous, current) {
        return previous.contentStatus != current.contentStatus;
      },
      builder: (context, state) {
        final setting = state.setting;
        final contentStatus = state.contentStatus;
        final placeList = state.placeList;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _SearchPlaceAppBar(
            titleName: _textTitle(setting),
            cancelAction: _cancelAction(context, setting),
            backButton: _backButton(
              context: context,
              setting: setting,
              contentStatus: contentStatus,
              placeList: placeList,
            ),
          ),
          body: _SearchPlaceContent(),
        );
      },
    );
  }

  String _textTitle(SearchPlaceSetting setting) {
    switch (setting) {
      case StartSearchPlaceSetting():
        return '출발 장소';
      case EndSearchPlaceSetting():
        return '장소';
      case ChangeStartSearchPlaceSetting():
        return '출발 장소';
      case ChangeEndSearchPlaceSetting():
        return '도착 장소';
    }
  }

  Function()? _cancelAction(
    BuildContext context,
    SearchPlaceSetting setting,
  ) {
    switch (setting) {
      case (ChangeEndSearchPlaceSetting() || ChangeStartSearchPlaceSetting()):
        return null;
      default:
        return () => context.read<SearchPlaceBloc>().add(PressCancelButton());
    }
  }

  Widget? _backButton({
    required BuildContext context,
    required SearchPlaceSetting setting,
    required SealedSearchPlaceContent contentStatus,
    required List<Place> placeList,
  }) {
    if (contentStatus is MapSearchPlaceContent) {
      return NaviBackButton(
        parentViewName: '장소목록',
        onPressed: () {
          context.read<SearchPlaceBloc>().add(
                SetSearchPlaceContentStatus(
                  contentStatus: ListSearchPlaceContent(placeList: placeList),
                ),
              );
        },
      );
    }

    switch (setting) {
      case (ChangeEndSearchPlaceSetting() || ChangeStartSearchPlaceSetting()):
        return NaviBackButton(
          parentViewName: '경로선택',
          onPressed: () => Navigator.of(context).pop(),
        );
      default:
        return null;
    }
  }
}
