import 'dart:ui';

import 'package:earlybuddy/app/app/view/app.dart';
import 'package:earlybuddy/presentation/schedule/kakaomap/kakaomap.dart';
import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

part 'searchplace_appbar.dart';
part 'searchplace_content/searchplace_searchbar.dart';
part 'searchplace_content/searchplace_listview.dart';
part 'searchplace_content/searchplace_content.dart';
part 'searchplace_content/searchplace_listitem.dart';

class SearchPlaceView extends StatelessWidget {
  const SearchPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _SearchPlaceAppBar(context: context),
      body: _SearchPlaceContent(),
    );
  }
}
