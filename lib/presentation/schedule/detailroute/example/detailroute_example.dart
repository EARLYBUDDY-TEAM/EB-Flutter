import 'package:earlybuddy/shared/eb_model/entity/entity.dart';
import 'package:earlybuddy/presentation/schedule/detailroute/view/detailroute_view.dart';
import 'package:flutter/material.dart';

part 'mock_detailroute_listitem.dart';
part 'mock_detailroute_listview.dart';

class DetailRouteExample extends StatelessWidget {
  const DetailRouteExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: _MockDetailRouteListItem(),
      home: _MockDetailrouteListview(),
    );
  }
}
