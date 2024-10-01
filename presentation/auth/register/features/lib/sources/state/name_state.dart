part of '../../eb_register_feature.dart';

final class NameState extends Equatable {
  final NameFormz name;
  final TextFieldStatus status;

  const NameState({
    this.name = const NameFormz(),
    this.status = TextFieldStatus.initial,
  });

  NameState copyWith({
    NameFormz? name,
    TextFieldStatus? status,
  }) {
    return NameState(
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        name,
        status,
      ];
}

final class NameFormz extends Equatable implements EBFormzAB {
  @override
  final String value;
  @override
  bool get isValid => validator();

  const NameFormz({
    this.value = '',
  });

  @override
  bool validator() {
    if (50 < value.length) {
      return false;
    }
    return true;
  }

  @override
  List<Object?> get props => [value];
}
