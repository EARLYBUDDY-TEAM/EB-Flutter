import 'package:earlybuddy/shared/assets/font.dart';
import 'package:flutter/material.dart';

class EBTextField extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final Function(String)? onChanged;

  const EBTextField({
    super.key,
    required this.labelText,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: Colors.blue,
      decoration: EBInputDecoration(
        labelText: labelText,
        errorText: errorText,
      ),
    );
  }
}

class EBInputDecoration extends InputDecoration {
  const EBInputDecoration({
    required super.labelText,
    required super.errorText,
  });

  @override
  FloatingLabelBehavior? get floatingLabelBehavior =>
      FloatingLabelBehavior.never;

  @override
  InputBorder? get focusedBorder => const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.blue,
        ),
      );

  @override
  InputBorder? get enabledBorder => const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.grey,
        ),
      );

  @override
  TextStyle? get labelStyle => const TextStyle(fontFamily: NanumSquare.regular);
}
