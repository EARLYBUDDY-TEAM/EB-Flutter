part of '../eb_root_feature.dart';

sealed class RootEvent {
  const RootEvent();
}

final class ChangeAuthStatus extends RootEvent {
  final AuthStatus status;

  const ChangeAuthStatus(this.status);
}

final class RequestLogout extends RootEvent {}
