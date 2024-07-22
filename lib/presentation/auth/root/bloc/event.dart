part of 'bloc.dart';

sealed class RootEvent {
  const RootEvent();
}

final class ChangeEBAuthStatus extends RootEvent {
  final EBAuthInfo ebAuthInfo;

  const ChangeEBAuthStatus(this.ebAuthInfo);
}

final class RequestLogout extends RootEvent {}
