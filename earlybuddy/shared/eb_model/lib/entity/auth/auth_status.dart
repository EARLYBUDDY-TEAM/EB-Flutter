part of '../../entity.dart';

sealed class AuthStatus extends Equatable {}

final class Authenticated extends AuthStatus {
  @override
  List<Object?> get props => [];
}

final class UnAuthenticated extends AuthStatus {
  @override
  List<Object?> get props => [];
}
