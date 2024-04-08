import 'package:earlybuddy/presentation/auth/auth.dart';
import 'package:earlybuddy/shared/eb_resources/assets/font.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

part 'home_calendar.dart';
part 'home_schedulecard.dart';
part 'home_transportcard.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.menu, color: Colors.white),
    );
  }
}

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
          appBar: AppBar(
            leading: MenuButton(onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            }),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
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
          ),
        ),
      ],
    );
  }
}
