import 'package:eb_model/entity.dart';
import 'package:eb_find_route_feature/eb_find_route_feature.dart';
import 'package:eb_find_route/eb_find_route.dart';
import 'package:flutter/material.dart';

part 'mock_findroute.dart';
part 'mock_findtroute_listitem.dart';

class FindRouteExample extends StatelessWidget {
  const FindRouteExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _MockFindRoute(),
      // home: _MockFindRouteListItem(),
    );
  }
}
