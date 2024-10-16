part of '../../eb_search_place.dart';

final class _SearchBar extends StatelessWidget {
  final color = Colors.grey;
  final double inset = 10;
  final double fontSize = 18;
  final double searchBarHeight;
  final double bottomSpace;

  const _SearchBar({
    required this.searchBarHeight,
    required this.bottomSpace,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPlaceBloc, SearchPlaceState>(
      buildWhen: (previous, current) {
        return previous.contentStatus != current.contentStatus;
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: state.contentStatus == ListSearchPlaceContent()
                ? []
                : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(0, 10),
                      blurRadius: 7,
                    ),
                  ],
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: bottomSpace),
            child: Container(
              height: searchBarHeight,
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
            ),
          ),
        );
      },
    );
  }
}

class _SearchBarSearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<SearchPlaceBloc>().add(PressSearchButton()),
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
          _controller.text = searchText;
          _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: searchText.length));
          return TextField(
            onChanged: (searchText) => context
                .read<SearchPlaceBloc>()
                .add(ChangeSearchText(searchText)),
            controller: _controller,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: FontFamily.nanumSquareBold,
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
                fontFamily: FontFamily.nanumSquareBold,
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
      onPressed: () => context.read<SearchPlaceBloc>().add(PressResetButton()),
      icon: const Icon(
        Icons.cancel_outlined,
        color: Colors.grey,
      ),
    );
  }
}
