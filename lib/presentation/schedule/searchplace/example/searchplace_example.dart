import 'package:earlybuddy/presentation/schedule/searchplace/view/view.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

part 'mock_modalsearchplace.dart';
part 'mock_searchplace.dart';

class SearchPlaceExample extends StatelessWidget {
  const SearchPlaceExample({super.key});

  @override
  Widget build(BuildContext context) {
    // return const MockModalSearchPlace();
    return const MockSearchPlace();
  }
}
