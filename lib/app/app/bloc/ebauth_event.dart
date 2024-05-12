part of 'ebauth_bloc.dart';

sealed class EBAuthEvent {
  const EBAuthEvent();
}

final class EBAuthStatusChanged extends EBAuthEvent {
  final EBAuthInfo ebAuthInfo;

  const EBAuthStatusChanged(this.ebAuthInfo);
}

final class EBAuthLogoutRequested extends EBAuthEvent {}
