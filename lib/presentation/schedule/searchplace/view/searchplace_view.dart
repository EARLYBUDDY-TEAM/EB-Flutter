import 'package:earlybuddy/domain/delegate/searchplace_delegate.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/bloc/bloc.dart';
import 'package:earlybuddy/shared/eb_uikit/resources/eb_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

part 'appbar.dart';
part 'content/searchplace_content.dart';
part 'content/searchbar.dart';
part 'content/list/listview.dart';
part 'content/list/listitem.dart';
part 'content/ebkakaomap/ebkakaomap_view.dart';
part 'content/ebkakaomap/placeinfo.dart';
part 'content/ebkakaomap/content.dart';

final class SearchPlaceView extends StatelessWidget {
  SearchPlaceSetting setting;
  SearchPlaceDelegate delegate;
  SearchPlaceState? searchPlaceState;
  Function(Place)? selectAction;
  Function()? cancelAction;

  static const routeName = 'SearchPlaceView';

  SearchPlaceView({
    super.key,
    required this.setting,
    required this.delegate,
    this.searchPlaceState,
    this.selectAction,
    this.cancelAction,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchPlaceBloc(
        delegate: delegate,
        setting: setting,
        searchPlaceState: searchPlaceState,
        selectAction: selectAction,
        cancelAction: cancelAction,
      ),
      child: const _EBSearchPlaceView(),
    );
  }
}

final class _EBSearchPlaceView extends StatelessWidget {
  const _EBSearchPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SearchPlaceBloc, SearchPlaceState, SearchPlaceSetting>(
      selector: (state) {
        return state.viewState.setting;
      },
      builder: (context, setting) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _SearchPlaceAppBar(
            textTitle: setting == SearchPlaceSetting.start ? '출발 장소' : '장소',
            cancelAction: () =>
                context.read<SearchPlaceBloc>().add(PressCancelButton()),
          ),
          body: _SearchPlaceContent(),
        );
      },
    );
  }
}
