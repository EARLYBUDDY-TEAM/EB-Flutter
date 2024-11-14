part of '../../../eb_find_route_feature.dart';

sealed class SealedFindRouteSetting extends Equatable {}

final class ReadFindRouteSetting extends SealedFindRouteSetting {
  final EBPath path;

  ReadFindRouteSetting({
    required this.path,
  });

  @override
  List<Object?> get props => [path];
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
  final SchedulePath schedulePath;
  final MaterialPageRoute Function(BuildContext context) pageChangeStartPlace;
  final MaterialPageRoute Function(BuildContext context) pageChangeEndPlace;

  WriteAndUpdateFindRouteSetting({
    required this.schedulePath,
    required this.pageChangeStartPlace,
    required this.pageChangeEndPlace,
  });

  @override
  List<Object?> get props => [
        schedulePath,
        pageChangeEndPlace,
        pageChangeStartPlace,
      ];
}
