import 'dart:developer';

import 'package:eb_model/entity.dart';
import 'package:eb_find_route_feature/eb_find_route_feature.dart';
import 'package:eb_find_route/eb_find_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eb_delegate/eb_delegate.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_state/eb_state.dart';
import 'package:eb_uikit/eb_uikit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

part 'mock_findroute.dart';
part 'helper/mock_findroute_helper.dart';

final class FindRouteExample extends StatelessWidget {
  const FindRouteExample({super.key});

  @override
  Widget build(BuildContext context) {
    return _MockFindRouteView.empty(context);
  }
}
