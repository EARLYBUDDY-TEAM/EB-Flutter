import 'dart:developer';

import 'package:earlybuddy/shared/eb_model/entity/entity.dart';
import 'package:earlybuddy/presentation/schedule/detailroute/detailroute.dart';
import 'package:earlybuddy/presentation/schedule/findroute/bloc/bloc.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appbar.dart';
part 'findroute_content/info/infoview.dart';
part 'findroute_content/list/sortview.dart';
part 'findroute_content/list/listview.dart';
part 'findroute_content/list/listitem/listitem.dart';
part 'findroute_content/list/listitem/listitem_routeinfo.dart';
part 'findroute_content/list/listitem/routeline/routeline.dart';
part 'findroute_content/list/listitem/routeline/transportline.dart';

final class FindRouteView extends StatelessWidget {
  final Place start;
  final Place end;
  final String? parentName;
  Function()? backAction;
  Function()? cancelAction;

  FindRouteView({
    super.key,
    required this.start,
    required this.end,
    this.parentName,
    this.backAction,
    this.cancelAction,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FindRouteBloc(
        start: start,
        end: end,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _FindRouteAppBar(
          parentName: parentName,
          backAction: backAction,
          cancelAction: cancelAction,
        ),
        body: Column(
          children: [
            _FindRouteInfoView(
              startName: start.name,
              endName: end.name,
            ),
            const _FindRouteListView(),
          ],
        ),
      ),
    );
  }
}
