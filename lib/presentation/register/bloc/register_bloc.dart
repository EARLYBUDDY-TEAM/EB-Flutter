import 'package:earlybuddy/presentation/presentation_model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterEmailChanged>(onRegisterEmailChanged);
    on<RegisterPasswordChanged>(onRegisterPasswordChanged);
  }

  void onRegisterEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    final isValidEmail = Formz.validate([email]);

    emit(
      state.copyWith(
        emailState:
            state.emailState.copyWith(email: email, isValidEmail: isValidEmail),
        inputIsValid: Formz.validate([email, state.passwordState.password]),
      ),
    );
  }

  void onRegisterPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    final isValidPassword = Formz.validate([password]);

    emit(
      state.copyWith(
        passwordState: state.passwordState
            .copyWith(password: password, isValidPassword: isValidPassword),
        inputIsValid: Formz.validate([password, state.emailState.email]),
      ),
    );
  }
}
