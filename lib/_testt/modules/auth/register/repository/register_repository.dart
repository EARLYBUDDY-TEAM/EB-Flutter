import 'dart:math';
import 'package:earlybuddy/_testt/modules/auth/register/model/register_model.dart';

class RegisterRepository {
  static final RegisterRepository instance = RegisterRepository._internal();

  factory RegisterRepository() => instance;
  RegisterRepository._internal();

  // Future<void> createUser({required RegisterRequest registerRequest}) async {
  //   return Future.delayed(const Duration(seconds: 3), () {
  //     Random r = Random();
  //     if (r.nextBool() == true) {
  //       return;
  //     } else {
  //       throw Exception('createUser');
  //     }
  //   });
  // }

  Future<void> createUser() async {
    return Future.delayed(const Duration(seconds: 3), () {
      Random r = Random();
      if (r.nextBool() == true) {
        return;
      } else {
        throw Exception('createUser');
      }
    });
  }
}
