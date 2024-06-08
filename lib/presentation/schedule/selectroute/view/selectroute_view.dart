import 'package:earlybuddy/shared/eb_resources/assets/color.dart';
import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'selectroute_appbar.dart';
part 'selectroute_content/selectroute_content.dart';
part 'selectroute_content/info/selectroute_infoview.dart';
part 'selectroute_content/sort/selectroute_sortview.dart';
part 'selectroute_content/list/selectroute_listview.dart';

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
