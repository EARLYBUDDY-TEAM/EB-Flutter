import 'package:eb_model/entity.dart';
import 'package:eb_search_place_feature/eb_search_place_feature.dart';
import 'package:eb_resource/eb_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:eb_delegate/eb_delegate.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_uikit/eb_uikit.dart';

part 'sources/searchplace_view.dart';
part 'sources/appbar.dart';
part 'sources/content/searchplace_content.dart';
part 'sources/content/searchbar.dart';
part 'sources/content/list/searchplace_listview.dart';
part 'sources/content/list/searchplace_listitem.dart';
part 'sources/content/ebkakaomap/ebkakaomap_view.dart';
part 'sources/content/ebkakaomap/ebkakao_placeinfo.dart';
part 'sources/content/ebkakaomap/ebkakao_content.dart';

final class PrepareEBSearchPlace {
  static void initializeKakaoMap({
    required String appKey,
    required String baseUrl,
  }) {
    AuthRepository.initialize(
      appKey: appKey,
      baseUrl: baseUrl,
    );
  }
}
