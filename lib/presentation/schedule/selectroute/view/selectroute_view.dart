import 'dart:math';

import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/material.dart';

part 'selectroute_appbar.dart';
part 'selectroute_content/selectroute_content.dart';
part 'selectroute_content/info/selectroute_infoview.dart';
part 'selectroute_content/list/selectroute_sortview.dart';
part 'selectroute_content/list/selectroute_listview.dart';
part 'selectroute_content/list/listitem/selectroute_listitem.dart';
part 'selectroute_content/list/listitem/listitem_routeinfo.dart';
part 'selectroute_content/list/listitem/routeline/routeline.dart';
part 'selectroute_content/list/listitem/routeline/dashline.dart';
part 'selectroute_content/list/listitem/routeline/transportline.dart';

class SelectRouteView extends StatelessWidget {
  const SelectRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _SelectRouteAppBar(
        cancelAction: () {},
      ),
      body: _SelectRouteContent(),
    );
  }
}
