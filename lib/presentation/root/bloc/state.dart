part of 'bloc.dart';

final class RootState extends Equatable {
  final AuthStatus status;

  RootState({
    AuthStatus? status,
  }) : status = status ?? UnAuthenticated();

  RootState copyWith({
    AuthStatus? status,
  }) {
    return RootState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
