import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/domain_model/sources/domain_model.dart';
import 'package:earlybuddy/presentation/schedule/findroute/bloc/bloc.dart';
import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
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
  const FindRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FindRouteBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _FindRouteAppBar(
          cancelAction: () {},
        ),
        body: _FindRouteContent(),
      ),
    );
  }
}
