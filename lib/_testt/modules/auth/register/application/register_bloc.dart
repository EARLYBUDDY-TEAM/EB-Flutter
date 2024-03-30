import 'package:earlybuddy/_testt/modules/auth/register/application/register_event.dart';
import 'package:earlybuddy/_testt/modules/auth/register/application/register_state.dart';
import 'package:earlybuddy/_testt/modules/auth/register/repository/register_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository _repository = RegisterRepository.instance;

  RegisterBloc() : super(RegisterInitState()) {
    on<RegisterRequestEvent>(_requestEvent);
  }

  Future<void> _requestEvent(
      RegisterRequestEvent event, Emitter<RegisterState> emit) async {
    try {
      await _repository.createUser();
    } catch (_error) {
      print(_error);
    }
  }
}
