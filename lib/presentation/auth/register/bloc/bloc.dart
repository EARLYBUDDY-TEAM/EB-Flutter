import 'dart:developer';

import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state/state.dart';
part 'state/email_state.dart';
part 'state/password_state.dart';
part 'state/passwordconfirm_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required EBAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const RegisterState()) {
    on<ChangeEmail>(_onChangeEmail);
    on<ChangePassword>(_onChangePassword);
    on<ChangePasswordConfirm>(_onChangePasswordConfirm);
    on<PressRegisterButton>(_onPressRegisterButton);
    on<PressAlertOkButton>(_onPressAlertOkButton);
  }

  final EBAuthRepository _authRepository;

  void _onChangeEmail(
    ChangeEmail event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email(value: event.email);
    EmailFormStatus status;
    if (email.value.isEmpty) {
      status = EmailFormStatus.initial;
    } else {
      status = email.isValid ? EmailFormStatus.typing : EmailFormStatus.onError;
    }
    final emailState = state.emailState.copyWith(
      email: email,
      status: status,
    );
    emit(state.copyWith(emailState: emailState));
  }

  void _onChangePassword(
    ChangePassword event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password(value: event.password);
    PasswordFormStatus passwordStatus;
    if (password.value.isEmpty) {
      passwordStatus = PasswordFormStatus.initial;
    } else {
      passwordStatus = password.isValid
          ? PasswordFormStatus.typing
          : PasswordFormStatus.onError;
    }
    final passwordState = PasswordState(
      password: password,
      status: passwordStatus,
    );

    final passwordConfirm = state.passwordConfirmState.passwordConfirm
        .copyWith(origin: event.password);
    PasswordConfirmFormStatus passwordConfirmStatus;
    if (passwordConfirm.value.isEmpty) {
      passwordConfirmStatus = PasswordConfirmFormStatus.initial;
    } else {
      passwordConfirmStatus = passwordConfirm.isValid
          ? PasswordConfirmFormStatus.typing
          : PasswordConfirmFormStatus.onError;
    }
    final passwordConfirmState = state.passwordConfirmState.copyWith(
      passwordConfirm: passwordConfirm,
      status: passwordConfirmStatus,
    );
    emit(
      state.copyWith(
        passwordState: passwordState,
        passwordConfirmState: passwordConfirmState,
      ),
    );
  }

  void _onChangePasswordConfirm(
    ChangePasswordConfirm event,
    Emitter<RegisterState> emit,
  ) {
    final passwordConfirm = state.passwordConfirmState.passwordConfirm
        .copyWith(value: event.passwordConfirm);
    PasswordConfirmFormStatus status;
    if (passwordConfirm.value.isEmpty) {
      status = PasswordConfirmFormStatus.initial;
    } else {
      status = passwordConfirm.isValid
          ? PasswordConfirmFormStatus.typing
          : PasswordConfirmFormStatus.onError;
    }

    final passwordConfirmState = PasswordConfirmState(
      passwordConfirm: passwordConfirm,
      status: status,
    );
    emit(
      state.copyWith(passwordConfirmState: passwordConfirmState),
    );
  }

  void _onPressRegisterButton(
    PressRegisterButton event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.inputIsValid) {
      emit(state.copyWith(status: RegisterStatus.inProgress));

      final int statusCode = await _authRepository.register(
        email: state.emailState.email.value,
        password: state.passwordState.password.value,
      );

      switch (statusCode) {
        case (>= 200 && < 300):
          emit(state.copyWith(status: RegisterStatus.initial));
        case (400):
          emit(state.copyWith(status: RegisterStatus.onErrorNotCorrectUser));
        case (401):
          emit(state.copyWith(status: RegisterStatus.onErrorExsitUser));
        default:
          emit(state.copyWith(status: RegisterStatus.onErrorUnknown));
      }
    } else {
      emit(state.copyWith(status: RegisterStatus.onErrorNotCorrectUser));
    }
  }

  void _onPressAlertOkButton(
    PressAlertOkButton event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(status: RegisterStatus.initial));
  }
}
