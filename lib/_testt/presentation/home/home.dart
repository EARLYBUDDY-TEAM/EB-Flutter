import 'package:earlybuddy/_testt/presentation/home/cards/transport_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'background.dart';
import 'cards/schedule_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomeBackground(),
        Scaffold(
          appBar: AppBar(
            leading: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
            backgroundColor: Colors.transparent,
          ),
          // extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: const HomeContent(),
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const ScheduleCard(),
          const SizedBox(
            height: 20,
          ),
          const TransportCard(),
          Calendar(),
        ],
      ),
    );
  }
}

class Calendar extends StatelessWidget {
  final DateTime focusedDay = DateTime.now();
  final DateTime firstDay = DateTime.utc(2020, 01, 01);
  final DateTime lastDay = DateTime.utc(2030, 01, 01);

  Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: focusedDay,
      firstDay: firstDay,
      lastDay: lastDay,
      locale: 'ko_KR',
    );
  }
}
