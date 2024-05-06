part of '../searchplace_view.dart';

final class _SearchPlaceSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const color = Colors.grey;
    const double inset = 10;

    return Padding(
      padding: const EdgeInsets.all(inset),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: inset),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: color,
                ),
              ),
              // const TextField(
              //   decoration: InputDecoration(
              //     labelText: '검색 또는 주소 입력',
              //     labelStyle: TextStyle(color: color),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
