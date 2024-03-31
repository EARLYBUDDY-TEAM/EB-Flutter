import 'package:earlybuddy/presentation/auth/auth.dart';
import 'package:earlybuddy/shared/assets/font.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

part 'home_calendar.dart';
part 'home_schedulecard.dart';
part 'home_transportcard.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   static Route<void> route() {
//     return MaterialPageRoute<void>(builder: (_) => const HomeView());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Builder(
//               builder: (context) {
//                 final userID = context.select(
//                   (AuthBloc bloc) => bloc.state.user.id,
//                 );
//                 return Text('UserID : $userID');
//               },
//             ),
//             ElevatedButton(
//               child: const Text('Logout'),
//               onPressed: () {
//                 context.read<AuthBloc>().add(AuthLogoutRequested());
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

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
        WaveBackground(),
        Scaffold(
          appBar: AppBar(
            leading: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
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
