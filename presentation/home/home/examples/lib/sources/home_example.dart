import 'package:eb_home/eb_home.dart';
import 'package:eb_delegate/eb_delegate.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_uikit/eb_uikit.dart';
import 'package:eb_event/eb_event.dart';
import 'package:eb_model/entity.dart';
import 'package:eb_home_feature/eb_home_feature.dart';
import 'package:eb_repository_interface/eb_repository_interface.dart';
import 'package:eb_resource/eb_resource.dart';
import 'package:eb_state/eb_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'home/mock_alert_home_view.dart';
part 'home/mock_bottom_schedulecardview.dart';
part 'home/mock_home_view.dart';
part 'home/mock_home_calendar.dart';
part 'middle/mock_middle_transport_info_card.dart';
part 'middle/mock_middle_transport_view.dart';
part 'helper/mock_data.dart';
part 'home/mock_register_confetti_view.dart';
part 'helper/mock_schedule_path.dart';

final class HomeExample extends StatelessWidget {
  const HomeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MockMiddleTransportView();
    // return const Text('');
    // return MockHomeView();
    // return const MockMiddleTransportView();
    // final mockRegisterConfettiView = MockRegisterConfettiView();
    // return mockRegisterConfettiView;
  }
}
