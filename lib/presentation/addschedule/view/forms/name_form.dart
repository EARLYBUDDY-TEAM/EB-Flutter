part of '../view.dart';

class _NameForm extends StatelessWidget {
  final Color color = Colors.grey;
  final double fontSize;

  const _NameForm({
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return _RoundRectForm(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Column(
          children: [
            _TitleInput(
              color: color,
              fontSize: fontSize,
            ),
            _MemoInput(
              color: color,
              fontSize: fontSize,
            ),
          ],
        ),
      ),
    );
  }
}

final class _MemoInput extends StatelessWidget {
  final Color color;
  final double fontSize;

  const _MemoInput({
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 150),
      child: TextField(
        onChanged: (_) {},
        keyboardType: TextInputType.multiline,
        maxLines: null,
        cursorColor: color,
        decoration: InputDecoration(
          labelText: '메모',
          border: InputBorder.none,
          labelStyle: TextStyle(
            fontFamily: NanumSquare.bold,
            fontSize: fontSize,
            color: color,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}

final class _TitleInput extends StatelessWidget {
  final Color color;
  final double fontSize;

  const _TitleInput({
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (_) {},
      cursorColor: color,
      decoration: InputDecoration(
        labelText: '제목',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: color,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: color,
          ),
        ),
        labelStyle: TextStyle(
          fontFamily: NanumSquare.bold,
          fontSize: fontSize,
          color: color,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}