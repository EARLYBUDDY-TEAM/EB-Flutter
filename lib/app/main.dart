import 'dart:developer';

import 'package:earlybuddy/presentation/home/view/view.dart';
import 'package:earlybuddy/presentation/register/register.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';

import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  runApp(const App());
  // runApp(const TestApp());

  // var testDecoder = TestDecoder();
  // var testModel = testDecoder.decode();
  // log(testModel.toString());
  // log(testModel.name);
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: RegisterView(),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: TestScheduleAddButton(),
      ),
    );
  }
}

class TestScheduleAddButton extends StatelessWidget {
  const TestScheduleAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          gradient: LinearGradient(
            colors: [
              EBColors.purple2,
              EBColors.blue1,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
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
