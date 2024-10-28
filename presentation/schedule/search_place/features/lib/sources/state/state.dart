part of '../../eb_search_place_feature.dart';

final class SearchPlaceState extends Equatable {
  final SearchPlaceSetting setting;
  final String searchText;
  final List<Place> placeList;
  final SealedSearchPlaceContent contentStatus;

  SearchPlaceState({
    required this.setting,
    String? searchText,
    List<Place>? placeList,
    SealedSearchPlaceContent? contentStatus,
  })  : searchText = searchText ?? '',
        placeList = placeList ?? [],
        contentStatus =
            contentStatus ?? ListSearchPlaceContent(placeList: const []);

  SearchPlaceState copyWith({
    String? searchText,
    List<Place>? placeList,
    SealedSearchPlaceContent? contentStatus,
  }) {
    return SearchPlaceState(
      setting: setting,
      searchText: searchText ?? this.searchText,
      placeList: placeList ?? this.placeList,
      contentStatus: contentStatus ?? this.contentStatus,
    );
  }

  @override
  List<Object?> get props => [
        setting,
        searchText,
        placeList,
        contentStatus,
      ];
}
