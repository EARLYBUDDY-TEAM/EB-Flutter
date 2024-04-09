import 'package:earlybuddy/presentation/auth/auth.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:earlybuddy/presentation/addschedule/addschedule.dart';

part 'home_appbar.dart';
part 'home_calendar.dart';
part 'home_schedulecard.dart';
part 'home_transportcard.dart';
part 'home_schedule_add_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeView());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white),
        const WaveBackground(),
        Scaffold(
          appBar: HomeAppBar(),
          backgroundColor: Colors.transparent,
          body: const Stack(
            alignment: Alignment.bottomRight,
            children: [
              HomeContent(),
              HomeScheduleAddButton(),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const ScheduleCard(),
          const SizedBox(height: 30),
          const TransportCard(),
          const SizedBox(height: 30),
          Calendar(),
        ],
      ),
    );
  }
}
