import 'package:earlybuddy/presentation/register/register.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(const App());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterView(),
    );
  }
}

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
