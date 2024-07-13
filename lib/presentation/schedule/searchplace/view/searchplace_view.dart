import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/bloc/bloc.dart';
import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

part 'searchplace_appbar.dart';
part 'searchplace_content/searchplace_content.dart';
part 'searchplace_content/searchbar.dart';
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
    Function(Place)? selectAction,
    Function()? cancelAction,
  }) : _searchPlaceBloc = searchPlaceBloc ?? SearchPlaceBloc() {
    if (selectAction != null) {
      _searchPlaceBloc.selectAction = selectAction;
    }
    if (cancelAction != null) {
      _searchPlaceBloc.cancelAction = cancelAction;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchPlaceBloc,
      child: _SearchPlaceView(),
    );
  }
}

final class _SearchPlaceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _SearchPlaceAppBar(
        cancelAction: () =>
            context.read<SearchPlaceBloc>().add(PressCancelButton()),
      ),
      body: _SearchPlaceContent(),
    );
  }
}
