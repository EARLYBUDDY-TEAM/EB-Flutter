part of '../../selectroute_view.dart';

class _SelectRouteListView extends StatelessWidget {
  const _SelectRouteListView();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        itemCount: 30,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            width: double.infinity,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          );
        },
        separatorBuilder: ((context, index) {
          return const Divider(height: 1);
        }),
        padding: const EdgeInsets.all(0.0),
      ),
    );
  }
}
