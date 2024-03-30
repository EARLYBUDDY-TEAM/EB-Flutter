import 'package:equatable/equatable.dart';

enum RegisterError {
  none,
  createUser,
}

abstract class RegisterState extends Equatable {
  final RegisterError error;

  const RegisterState({
    this.error = RegisterError.none,
  });
}

class RegisterInitState extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterRequestState extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterFinishState extends RegisterState {
  @override
  List<Object?> get props => [error];
}



// abstract class RegisterState extends Equatable {
//   final bool isError;

//   const RegisterState({
//     this.isError = false,
//   });
// }

// class RegisterInitState extends RegisterState {
//   @override
//   List<Object?> get props => [];
// }

// class RegisterRequestState extends RegisterState {
//   @override
//   List<Object?> get props => [];
// }

// class RegisterFinishState extends RegisterState {
//   @override
//   List<Object?> get props => [isError];
// }
