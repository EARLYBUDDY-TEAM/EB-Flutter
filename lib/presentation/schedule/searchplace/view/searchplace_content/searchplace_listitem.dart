part of '../searchplace_view.dart';

final class _SearchPlaceListItem extends StatelessWidget {
  final Place place;

  const _SearchPlaceListItem({
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      title: _content(
        context: context,
        place: place,
      ),
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const KakaoMapView(),
        //   ),
        // );
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
          fontFamily: NanumSquare.regular,
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
                        fontFamily: NanumSquare.bold,
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
                    const Text('거리km'),
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
