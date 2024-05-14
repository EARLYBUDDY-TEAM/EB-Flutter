import 'package:earlybuddy/domain/repository/searchplace/source/model/model.dart';
import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

part 'ebkakaomap_content.dart';
part 'ebkakaomap_placeinfo.dart';

final class EBKakaoMapView extends StatelessWidget {
  final Place place;

  const EBKakaoMapView({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: _EBKakaoMapContent(place: place),
          ),
          Expanded(
            flex: 2,
            child: _EBKakaoMapPlaceInfo(place: place),
          ),
        ],
      ),
    );
  }
}
