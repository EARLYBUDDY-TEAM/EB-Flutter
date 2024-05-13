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
          _SearchBarSearchButton(),
          _SearchBarTextField(),
          _SearchBarCancelButton(),
        ],
      ),
    );
  }
}

class _SearchBarSearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () =>
          context.read<SearchPlaceBloc>().add(SearchPlaceSearchButtonPressed()),
      icon: const Icon(
        Icons.search,
        color: Colors.grey,
      ),
    );
  }
}

class _SearchBarTextField extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocSelector<SearchPlaceBloc, SearchPlaceState, String>(
        selector: (state) => state.searchText,
        builder: (context, searchText) {
          // is it ok?
          if (searchText.isEmpty) {
            _controller.clear();
          }
          return TextField(
            onChanged: (searchText) => context
                .read<SearchPlaceBloc>()
                .add(SearchPlaceSearchTextChanged(searchText)),
            controller: _controller,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: NanumSquare.bold,
              fontSize: 18,
            ),
            cursorColor: Colors.grey,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              labelText: '검색 또는 주소 입력',
              labelStyle: TextStyle(
                color: Colors.grey,
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

class _SearchBarCancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () =>
          context.read<SearchPlaceBloc>().add(SearchPlaceCancelButtonPressed()),
      icon: const Icon(
        Icons.cancel_outlined,
        color: Colors.grey,
      ),
    );
  }
}
