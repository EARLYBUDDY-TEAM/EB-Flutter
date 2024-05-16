import 'package:earlybuddy/domain/repository/searchplace/searchplace_repository.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/bloc/searchplace_bloc.dart';
import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

part 'searchplace_appbar.dart';
part 'searchplace_content/searchplace_content.dart';
part 'searchplace_content/searchbar/searchplace_searchbar.dart';
part 'searchplace_content/list/searchplace_listview.dart';
part 'searchplace_content/list/searchplace_listitem.dart';
part 'searchplace_content/ebkakaomap/ebkakaomap_view.dart';
part 'searchplace_content/ebkakaomap/ebkakaomap_placeinfo.dart';
part 'searchplace_content/ebkakaomap/ebkakaomap_content.dart';

final class SearchPlaceView extends StatelessWidget {
  final SearchPlaceBloc _searchPlaceBloc;

  SearchPlaceView({
    super.key,
    SearchPlaceBloc? searchPlaceBloc,
  }) : _searchPlaceBloc = searchPlaceBloc ?? SearchPlaceBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchPlaceBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _SearchPlaceAppBar(context: context),
        body: _SearchPlaceContent(),
      ),
    );
  }
}
