import 'package:flutter/material.dart';

class EBImages {
  static _EBAssetImage splash = const _EBAssetImage('splash.png');
  static _EBAssetImage loginTitle = const _EBAssetImage('login_title.png');
  static _EBAssetImage markFindRoute =
      const _EBAssetImage('mark_findroute.png');
}

class _EBAssetImage extends AssetImage {
  const _EBAssetImage(String fileName) : super('assets/images/$fileName');
}
