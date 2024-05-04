import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

part 'navermap_navibar.dart';
part 'navermap_content/navermap_searchbar.dart';
part 'navermap_content/navermap_searchresultview.dart';
part 'navermap_content/navermap_content.dart';

class NaverMapView extends StatelessWidget {
  const NaverMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (childContext1) => Builder(
            builder: (childContext2) => CupertinoPageScaffold(
              navigationBar: _NaverMapNaviBar(context: context),
              child: _NaverMapContent(childContext: childContext2),
            ),
          ),
        ),
      ),
    );
  }
}
