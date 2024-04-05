import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';

import 'package:earlybuddy/shared/assets/image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(const App());

  // runApp(const TestApp());
}

// class TestApp extends StatelessWidget {
//   const TestApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: TestMain(),
//     );
//   }
// }

// class TestMain extends StatelessWidget {
//   const TestMain({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.red,
//       body: Center(
//         child: LoginTitle(),
//       ),
//     );
//   }
// }

// class LoginTitle extends StatelessWidget {
//   const LoginTitle({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       height: 200,
//       decoration: BoxDecoration(
//         image: DecorationImage(image: EBImages.loginTitle, fit: BoxFit.fill),
//       ),
//     );
//   }
// }
