import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:earlybuddy/shared/eb_uikit/sources/eb_sources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'listview/listview.dart';
part 'listview/listitem/listitem.dart';
part 'listview/listitem/listitem_walk.dart';
part 'listview/listitem/listitem_other.dart';
part 'listview/listitem/info/startinfo.dart';
part 'listview/listitem/info/laneinfo.dart';
part 'listview/listitem/info/endinfo.dart';
part 'listview/listitem/icon/icontransport.dart';

class DetailRouteView extends StatelessWidget {
  const DetailRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('testefaea'),
      ),
    );
  }
}
