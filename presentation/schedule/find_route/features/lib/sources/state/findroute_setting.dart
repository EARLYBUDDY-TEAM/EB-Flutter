part of '../../../eb_find_route_feature.dart';

sealed class SealedFindRouteSetting extends Equatable {}

final class ReadFindRouteSetting extends SealedFindRouteSetting {
  final List<EBSubPath> subPaths;

  ReadFindRouteSetting({
    required this.subPaths,
  });

  @override
  List<Object?> get props => [subPaths];
}

final class WriteFindRouteSetting extends SealedFindRouteSetting {
  final MaterialPageRoute Function(BuildContext context) pageChangeStartPlace;
  final MaterialPageRoute Function(BuildContext context) pageChangeEndPlace;

  WriteFindRouteSetting({
    required this.pageChangeStartPlace,
    required this.pageChangeEndPlace,
  });

  @override
  List<Object?> get props => [
        pageChangeEndPlace,
        pageChangeStartPlace,
      ];
}

final class WriteAndUpdateFindRouteSetting extends SealedFindRouteSetting {
  final MaterialPageRoute Function(BuildContext context) pageChangeStartPlace;
  final MaterialPageRoute Function(BuildContext context) pageChangeEndPlace;

  WriteAndUpdateFindRouteSetting({
    required this.pageChangeStartPlace,
    required this.pageChangeEndPlace,
  });

  @override
  List<Object?> get props => [
        pageChangeEndPlace,
        pageChangeStartPlace,
      ];
}
