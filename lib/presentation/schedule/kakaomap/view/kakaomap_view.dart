import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

part 'kakaomap_navibar.dart';
part 'kakaomap_content.dart';

final class KakaoMapView extends StatelessWidget {
  const KakaoMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _KakaoMapNaviBar(context: context),
      child: const _KakaoMapContent(),
    );
  }
}
