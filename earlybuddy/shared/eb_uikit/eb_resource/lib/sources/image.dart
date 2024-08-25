part of '../eb_resource.dart';

final class EBImages {
  static const _EBAssetImage splash = _EBAssetImage('splash.png');
  static const _EBAssetImage loginTitle = _EBAssetImage('login_title.png');
  static const _EBAssetImage markFindRoute =
      _EBAssetImage('mark_findroute.png');
  static _EBAssetImage odsay = const _EBAssetImage('odsay.png');
}

class _EBAssetImage extends AssetImage {
  const _EBAssetImage(String fileName) : super('assets/images/$fileName');
}
