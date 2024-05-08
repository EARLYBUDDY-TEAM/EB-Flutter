part of '../searchplace_view.dart';

final class _SearchPlaceSearchBar extends StatelessWidget {
  final color = Colors.grey;
  final double inset = 10;
  final double fontSize = 18;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          searchButton(),
          Flexible(child: textFormField()),
          cancelButton(),
        ],
      ),
    );
  }

  IconButton searchButton() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.search,
        color: color,
      ),
    );
  }

  TextFormField textFormField() {
    return TextFormField(
      cursorColor: color,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.zero,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        labelText: '검색 또는 주소 입력',
        labelStyle: TextStyle(
          color: color,
          fontFamily: NanumSquare.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }

  IconButton cancelButton() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.cancel_outlined,
        color: color,
      ),
    );
  }
}
