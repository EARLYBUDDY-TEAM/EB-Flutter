part of '../../../eb_search_place.dart';

final class _SearchPlaceListItem extends StatelessWidget {
  final Place place;

  const _SearchPlaceListItem({
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPlaceBloc, SearchPlaceState>(
      builder: (context, state) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          title: _content(
            context: context,
            place: place,
          ),
          onTap: () =>
              context.read<SearchPlaceBloc>().add(PressListItem(place: place)),
        );
      },
    );
  }

  Widget _content({
    required BuildContext context,
    required Place place,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DefaultTextStyle(
        style: const TextStyle(
          fontFamily: FontFamily.nanumSquareRegular,
          color: Colors.black87,
          fontSize: 15,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(
                        fontFamily: FontFamily.nanumSquareBold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(place.address),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(place.category),
                    Text('${place.distance}km'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}