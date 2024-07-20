import 'dart:developer';

import 'package:earlybuddy/presentation/schedule/addschedule/example/addschedule_example.dart';
import 'package:earlybuddy/presentation/schedule/detailroute/example/detailroute_example.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/example/searchplace_example.dart';
import 'package:earlybuddy/presentation/schedule/findroute/example/findroute_example.dart';
import 'package:earlybuddy/shared/eb_env/eb_env.dart';
import 'package:earlybuddy/shared/eb_uikit/example/eb_uikit_example.dart';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  final env = ENV.shared;
  await env.load();
  initializeKakaoMap(appKey: env.kakao_app_key, baseUrl: env.kakao_baseUrl);

  // runApp(const App());
  // runApp(const KakaoMapExample());
  // await getlocationdda

  // runApp(const EBUIkitExample());
  // runApp(const SearchPlaceExample());
  // runApp(const AddScheduleExample());
  runApp(const FindRouteExample());
  // runApp(const DetailRouteExample());

  // runApp(const TestStackPositionedExample());
}

void initializeKakaoMap({
  required String appKey,
  required String baseUrl,
}) {
  AuthRepository.initialize(
    appKey: appKey,
    baseUrl: baseUrl,
  );
}



// class TestStackPositionedExample extends StatelessWidget {
//   const TestStackPositionedExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: StackPositionedExample(),
//     );
//   }
// }

// class StackPositionedExample extends StatelessWidget {
//   const StackPositionedExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           decoration: BoxDecoration(
//               border: Border.all(width: 5, color: Colors.lightGreenAccent)),
//           child: Stack(
//             children: [
//               Positioned(
//                 left:
//                     50, // distance between this child's left edge & left edge of stack
//                 top:
//                     150, // distance between this child's top edge & top edge of stack
//                 child: Container(
//                   height: 100,
//                   width: 100,
//                   color: Colors.blue,
//                   alignment: Alignment.center,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
