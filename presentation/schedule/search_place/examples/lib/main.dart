import 'package:flutter/material.dart';
import 'sources/searchplace_example.dart';
import 'package:eb_search_place/eb_search_place.dart';
import 'package:eb_env/eb_env.dart';

void main() async {
  await prepareENV(dev: true);

  WidgetsFlutterBinding.ensureInitialized();
  PrepareEBSearchPlace.initializeKakaoMap(
    appKey: ENV_KAKAOMAP.appKey,
    baseUrl: ENV_KAKAOMAP.url,
  );
  // await LocationProvider.shared.checkPermission();

  runApp(SearchPlaceExample());
}
