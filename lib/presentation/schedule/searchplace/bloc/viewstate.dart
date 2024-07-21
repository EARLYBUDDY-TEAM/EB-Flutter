part of 'bloc.dart';

final class SearchPlaceViewState extends Equatable {
  final SearchPlaceSetting setting;
  final SearchPlaceContentStatus contentStatus;

  const SearchPlaceViewState({
    this.setting = SearchPlaceSetting.start,
    this.contentStatus = SearchPlaceContentStatus.search,
  });

  SearchPlaceViewState copyWith({
    SearchPlaceSetting? setting,
    SearchPlaceContentStatus? contentStatus,
  }) {
    return SearchPlaceViewState(
      setting: setting ?? this.setting,
      contentStatus: contentStatus ?? this.contentStatus,
    );
  }

  @override
  List<Object?> get props => [setting, contentStatus];
}

enum SearchPlaceSetting {
  start,
  end,
}

enum SearchPlaceContentStatus {
  search,
  map,
}
