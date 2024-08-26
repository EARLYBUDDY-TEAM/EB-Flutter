import 'package:eb_find_route/eb_find_route.dart';
import 'package:eb_delegate/eb_delegate.dart';
import 'package:eb_model/entity.dart';
import 'package:eb_search_place/eb_search_place.dart';
import 'package:eb_search_place_feature/eb_search_place_feature.dart';
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
