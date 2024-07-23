// import 'package:formz/formz.dart';

// enum PasswordValidationError { inValid }

// class Password extends FormzInput<String, PasswordValidationError> {
//   const Password.pure() : super.pure('');
//   const Password.dirty([super.value = '']) : super.dirty();

//   @override
//   PasswordValidationError? validator(String value) {
//     if (!checkPassword(password: value)) return PasswordValidationError.inValid;
//     return null;
//   }

//   bool checkPassword({required String password}) {
//     if (password.contains(' ') || password.trim().isEmpty) {
//       return false;
//     }

//     if (password.length < 6) {
//       return false;
//     }

//     if (!containDigitOrLetter(password)) {
//       return false;
//     }

//     return true;
//   }

//   bool containDigitOrLetter(String password) {
//     bool isDigit(String c) {
//       return RegExp(r'[0-9]').hasMatch(c);
//     }

//     bool isLetter(String c) {
//       return RegExp(r'[a-zA-z]').hasMatch(c);
//     }

//     bool digitFlag = false;
//     bool letterFlag = false;

//     for (int i = 0; i < password.length; i++) {
//       if (digitFlag && letterFlag) {
//         break;
//       }

//       String c = password[i];
//       if (isDigit(c)) {
//         digitFlag = true;
//       } else if (isLetter(c)) {
//         letterFlag = true;
//       }
//     }

//     return (digitFlag && letterFlag);
//   }
// }
