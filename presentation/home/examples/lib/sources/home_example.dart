import 'package:eb_home/eb_home.dart';
import 'package:eb_delegate/eb_delegate.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_uikit/eb_uikit.dart';
import 'package:eb_event/eb_event.dart';
import 'package:eb_model/entity.dart';
import 'package:eb_home_feature/eb_home_feature.dart';
import 'package:eb_repository_interface/eb_repository_interface.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mock_alert_home_view.dart';
part 'mock_bottom_schedulecardview.dart';
part 'mock_home_view.dart';
part 'mock_home_calendar.dart';
part 'mock_middle_transport_view.dart';

final class HomeExample extends StatelessWidget {
  const HomeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MockMiddleTransportView();
  }
}
