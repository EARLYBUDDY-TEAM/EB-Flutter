import 'package:earlybuddy/domain/delegate/searchplace_delegate.dart';
import 'package:earlybuddy/shared/eb_model/entity/entity.dart';
import 'package:earlybuddy/presentation/schedule/findroute/findroute.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/bloc/bloc.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/view/searchplace_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

part 'mock_modalsearchplace.dart';
part 'mock_searchplace.dart';
part 'mock_ebkakaomap.dart';

class SearchPlaceExample extends StatelessWidget {
  const SearchPlaceExample({super.key});

  @override
  Widget build(BuildContext context) {
    // return _MockSearchPlace();
    return _MockModalSearchPlaceForRoute();
    // // return _MockEBKakaoMapView();
  }
}
