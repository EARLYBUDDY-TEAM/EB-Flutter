part of '../../eb_search_place_feature.dart';

final class SearchPlaceState extends Equatable {
  final SearchPlaceSetting setting;
  final String searchText;
  final SealedSearchPlaceContent contentStatus;

  SearchPlaceState({
    required this.setting,
    String? searchText,
    SealedSearchPlaceContent? contentStatus,
  })  : searchText = searchText ?? '',
        contentStatus = contentStatus ?? ListSearchPlaceContent();

  SearchPlaceState copyWith({
    String? searchText,
    SealedSearchPlaceContent? contentStatus,
  }) {
    return SearchPlaceState(
      setting: setting,
      searchText: searchText ?? this.searchText,
      contentStatus: contentStatus ?? this.contentStatus,
    );
  }

  @override
  List<Object?> get props => [
        setting,
        searchText,
        contentStatus,
      ];
}
