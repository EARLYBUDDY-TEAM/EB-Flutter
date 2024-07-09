import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/presentation/schedule/findroute/bloc/bloc.dart';
import 'package:earlybuddy/presentation/schedule/findroute/view/view.dart';
import 'package:flutter/material.dart';

part 'mock_findroute.dart';
part 'mock_findtroute_listitem.dart';

class FindRouteExample extends StatelessWidget {
  const FindRouteExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MockFindRouteListItem(),
    );
  }
}
