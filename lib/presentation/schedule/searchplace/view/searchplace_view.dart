import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

part 'searchplace_navibar.dart';
part 'searchplace_content/searchplace_searchbar.dart';
part 'searchplace_content/searchplace_listview.dart';
part 'searchplace_content/searchplace_content.dart';
part 'searchplace_content/searchplace_listitem.dart';

class SearchPlaceView extends StatelessWidget {
  const SearchPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => Builder(
            builder: (childContext) => CupertinoPageScaffold(
              navigationBar: _SearchPlaceNaviBar(context: context),
              // child: _NaverMapContent(childContext: childContext),
              child: _SearchPlaceContent(),
            ),
          ),
        ),
      ),
    );
  }
}
