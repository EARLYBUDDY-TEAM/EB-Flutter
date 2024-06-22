import 'package:earlybuddy/presentation/schedule/selectroute/view/view.dart';
import 'package:flutter/material.dart';

part 'mock_selectroute.dart';
part 'mock_selectroute_listitem.dart';

class SelectRouteExample extends StatelessWidget {
  const SelectRouteExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MockSelectRoute();
    // return _MockSelectRouteListItem();
  }
}
