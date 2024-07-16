import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/presentation/schedule/findroute/bloc/bloc.dart';
import 'package:earlybuddy/shared/eb_uikit/resources/eb_resources.dart';
import 'package:earlybuddy/shared/eb_uikit/sources/eb_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appbar.dart';
part 'findroute_content/content.dart';
part 'findroute_content/info/infoview.dart';
part 'findroute_content/list/sortview.dart';
part 'findroute_content/list/listview.dart';
part 'findroute_content/list/listitem/listitem.dart';
part 'findroute_content/list/listitem/listitem_routeinfo.dart';
part 'findroute_content/list/listitem/routeline/routeline.dart';
part 'findroute_content/list/listitem/routeline/transportline.dart';

final class FindRouteView extends StatelessWidget {
  final Coordi start;
  final Coordi end;
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
        body: _FindRouteContent(),
      ),
    );
  }
}
