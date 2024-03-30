import 'package:earlybuddy/_testt/modules/auth/register/model/register_model.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {}

class RegisterRequestEvent extends RegisterEvent {
  // RegisterRequest registerInfo;

  // RegisterRequestEvent({required this.registerInfo});

  @override
  List<Object?> get props => [];
}
