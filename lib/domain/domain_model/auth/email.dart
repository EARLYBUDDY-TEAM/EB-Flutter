// import 'package:formz/formz.dart';

// enum EmailValidationError { invalid }

// class Email extends FormzInput<String, EmailValidationError> {
//   const Email.pure() : super.pure('');
//   const Email.dirty([super.value = '']) : super.dirty();

//   @override
//   EmailValidationError? validator(String value) {
//     // if (value.isEmpty) return EmailValidationError.empty;
//     if (!checkEmail(email: value)) {
//       return EmailValidationError.invalid;
//     }
//     return null;
//   }

//   bool checkEmail({required String email}) {
//     if (email.contains(' ') || email.isEmpty) {
//       return false;
//     }

//     int aet = '@'.allMatches(email).length;
//     if (aet != 1) {
//       return false;
//     }

//     List<String> parts = email.split('@');
//     String split1 = parts[0];
//     String split2 = parts[1];
//     if (split1.isEmpty || split2.isEmpty) {
//       return false;
//     }

//     return true;
//   }
// }