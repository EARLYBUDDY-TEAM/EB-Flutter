import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:flutter/material.dart';

part 'selectroute_appbar.dart';
part 'selectroute_content.dart';

class SelectRouteView extends StatelessWidget {
  const SelectRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _SelectRouteAppBar(
        cancelAction: () {},
      ),
      body: _SelectRouteContent(),
    );
  }
}
