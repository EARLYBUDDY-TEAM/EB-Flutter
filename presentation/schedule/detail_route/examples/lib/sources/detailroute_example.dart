import 'package:eb_model/entity.dart';
import 'package:eb_detail_route/eb_detail_route.dart';
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
