part of '../../../eb_register.dart';

final class _NickNameStateful extends StatefulWidget {
  final TextEditingController textEditingController;
  final int lenNickName;
  final Function(String) onChanged;
  final String? labelText;
  final String? errorText;
  final color = EBColors.blue2;

  _NickNameStateful({
    required this.textEditingController,
    required this.lenNickName,
    required this.onChanged,
    this.labelText,
    this.errorText,
  });

  @override
  State<StatefulWidget> createState() => _NickNameTextField();
}

final class _NickNameTextField extends State<_NickNameStateful> {
  String get _lenName {
    return widget.lenNickName == 0 ? "" : "  ${widget.lenNickName}   ";
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      onChanged: widget.onChanged,
      cursorColor: widget.color,
      decoration: _NickNameInputDecoration(
        widget.labelText,
        widget.errorText,
        widget.color,
        lenNickName: _lenName,
      ),
    );
  }
}

class _NickNameInputDecoration extends EBInputDecoration {
  final String lenNickName;

  _NickNameInputDecoration(
    super.labelText,
    super.errorText,
    super.color, {
    required this.lenNickName,
  });

  @override
  Widget? get suffix => Text(
        lenNickName,
        style: const TextStyle(
          fontFamily: FontFamily.nanumSquareRegular,
          fontSize: 13,
        ),
      );
}
