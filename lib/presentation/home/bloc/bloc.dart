import 'package:earlybuddy/domain/delegate/login_delegate.dart';
import 'package:earlybuddy/domain/delegate/register_delegate.dart';
import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EBAuthRepository _authRepository;
  final RegisterDelegate _registerDelegate;
  final LoginDelegate _loginDelegate;

  HomeBloc({
    required EBAuthRepository authRepository,
    required RegisterDelegate registerDelegate,
    required LoginDelegate loginDelegate,
  })  : _authRepository = authRepository,
        _registerDelegate = registerDelegate,
        _loginDelegate = loginDelegate,
        super(const HomeState()) {
    on<PressAddScheduleButton>(_onPressAddScheduleButton);
    on<PressMenuButton>(_onPressMenuButton);
    on<PressRegisterAlertOkButton>(_onPressRegisterAlertOkButton);
    on<DismissLoginSnackbar>(_onDismissLoginSnackbar);
  }

  void _onPressAddScheduleButton(
    PressAddScheduleButton event,
    Emitter<HomeState> emit,
  ) {}

  void _onPressMenuButton(
    PressMenuButton event,
    Emitter<HomeState> emit,
  ) {
    _authRepository.logOut();
  }

  void _onPressRegisterAlertOkButton(
    PressRegisterAlertOkButton event,
    Emitter<HomeState> emit,
  ) {
    _registerDelegate.clearFirstLogin();
  }

  void _onDismissLoginSnackbar(
    DismissLoginSnackbar event,
    Emitter<HomeState> emit,
  ) {
    _loginDelegate.clearIsSuccess();
  }
}
