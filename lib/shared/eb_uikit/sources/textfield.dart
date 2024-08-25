part of '../eb_sources.dart';

final class EBPasswordTextField extends StatefulWidget {
  final String? labelText;
  final String? errorText;
  final Function(String)? onChanged;

  final color = EBColors.blue2;

  EBPasswordTextField({
    super.key,
    this.labelText,
    this.errorText,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _EBPasswordTextFieldState();
}

final class _EBPasswordTextFieldState extends State<EBPasswordTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      cursorColor: widget.color,
      obscureText: isObscure,
      decoration: _EBPasswordInputDecoration(
        widget.labelText,
        widget.errorText,
        widget.color,
        isObscure,
        () => setState(() {
          isObscure = !isObscure;
        }),
      ),
    );
  }
}

class _EBPasswordInputDecoration extends _EBInputDecoration {
  bool isObscure;
  Function() onPressedEyeButton;

  _EBPasswordInputDecoration(
    super.labelText,
    super.errorText,
    super.color,
    this.isObscure,
    this.onPressedEyeButton,
  );

  @override
  Widget? get suffixIcon => IconButton(
        onPressed: onPressedEyeButton,
        icon: Icon(
          isObscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
          color: EBColors.text,
        ),
      );
}

final class EBTextField extends StatelessWidget {
  final String? labelText;
  final String? errorText;
  final Function(String)? onChanged;

  final color = EBColors.blue2;

  EBTextField({
    super.key,
    required this.labelText,
    required this.errorText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: color,
      decoration: _EBInputDecoration(
        labelText,
        errorText,
        color,
      ),
    );
  }
}

class _EBInputDecoration extends InputDecoration {
  @override
  String? labelText;
  @override
  String? errorText;
  Color color;

  _EBInputDecoration(this.labelText, this.errorText, this.color);

  @override
  InputBorder? get focusedBorder => UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: color,
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

  @override
  FloatingLabelBehavior? get floatingLabelBehavior =>
      FloatingLabelBehavior.never;
}
