part of 'eb_sources.dart';

class EBTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final String labelText;
  final String? errorText;
  final Color? cursorColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;

  const EBTextField({
    super.key,
    required this.onChanged,
    required this.labelText,
    this.errorText,
    this.cursorColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: cursorColor ?? EBColors.blue2,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: focusedBorderColor ?? EBColors.blue2,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: enabledBorderColor ?? Colors.grey,
          ),
        ),
        labelStyle: const TextStyle(fontFamily: NanumSquare.regular),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
