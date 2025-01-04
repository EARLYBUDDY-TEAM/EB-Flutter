part of '../../eb_register_feature.dart';

final class NickNameState extends Equatable {
  final NickNameFormz nickName;
  final TextFieldStatus status;

  const NickNameState({
    this.nickName = const NickNameFormz(),
    this.status = TextFieldStatus.initial,
  });

  NickNameState copyWith({
    NickNameFormz? nickName,
    TextFieldStatus? status,
  }) {
    return NickNameState(
      nickName: nickName ?? this.nickName,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        nickName,
        status,
      ];
}

final class NickNameFormz extends Equatable implements EBFormzAB {
  @override
  final String value;
  @override
  bool get isValid => validator();

  const NickNameFormz({
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
