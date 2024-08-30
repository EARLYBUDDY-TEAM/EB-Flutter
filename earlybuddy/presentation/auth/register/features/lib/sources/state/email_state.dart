part of '../../eb_register_feature.dart';

final class EmailState extends Equatable {
  final Email email;
  final EmailFormStatus status;

  const EmailState({
    this.email = const Email(),
    this.status = EmailFormStatus.initial,
  });

  EmailState copyWith({
    Email? email,
    EmailFormStatus? status,
  }) {
    return EmailState(
      email: email ?? this.email,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, status];
}

enum EmailFormStatus {
  initial,
  typing,
  onError,
}
