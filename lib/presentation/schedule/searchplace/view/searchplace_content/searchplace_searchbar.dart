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
          _SearchButton(),
          _SearchTextField(),
          _CancelButton(),
        ],
      ),
    );
  }
}

final class _SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.search,
        color: Colors.grey,
      ),
    );
  }
}

final class _SearchTextField extends StatelessWidget {
  final color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocBuilder<SearchPlaceBloc, SearchPlaceState>(
        builder: (context, state) {
          return TextFormField(
            onChanged: (searchText) => context
                .read<SearchPlaceBloc>()
                .add(SearchPlaceSearchTextChanged(searchText)),
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
                fontSize: 18,
              ),
            ),
          );
        },
      ),
    );
  }
}

final class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.cancel_outlined,
        color: Colors.grey,
      ),
    );
  }
}
