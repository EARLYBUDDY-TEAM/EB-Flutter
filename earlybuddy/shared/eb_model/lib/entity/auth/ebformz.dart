part of '../entity.dart';

abstract class EBFormzAB {
  String get value;
  bool get isValid => validator();
  bool validator();
}

final class Email extends Equatable implements EBFormzAB {
  @override
  final String value;
  @override
  bool get isValid => validator();

  const Email({
    this.value = '',
  });

  @override
  bool validator() {
    if (value.contains(' ') || value.isEmpty) {
      return false;
    }

    int aet = '@'.allMatches(value).length;
    if (aet != 1) {
      return false;
    }

    List<String> parts = value.split('@');
    String split1 = parts[0];
    String split2 = parts[1];
    if (split1.isEmpty || split2.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  List<Object?> get props => [value];
}

final class Password extends Equatable implements EBFormzAB {
  @override
  final String value;
  @override
  bool get isValid => validator();

  const Password({
    this.value = '',
  });

  @override
  bool validator() {
    if (value.contains(' ') || value.trim().isEmpty) {
      return false;
    }

    if (value.length < 6) {
      return false;
    }

    if (!containDigitOrLetter(value)) {
      return false;
    }

    return true;
  }

  bool containDigitOrLetter(String password) {
    bool isDigit(String c) {
      return RegExp(r'[0-9]').hasMatch(c);
    }

    bool isLetter(String c) {
      return RegExp(r'[a-zA-z]').hasMatch(c);
    }

    bool digitFlag = false;
    bool letterFlag = false;

    for (int i = 0; i < password.length; i++) {
      if (digitFlag && letterFlag) {
        break;
      }

      String c = password[i];
      if (isDigit(c)) {
        digitFlag = true;
      } else if (isLetter(c)) {
        letterFlag = true;
      }
    }

    return (digitFlag && letterFlag);
  }

  @override
  List<Object?> get props => [value];
}
