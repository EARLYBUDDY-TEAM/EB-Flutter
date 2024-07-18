part of '../detailroute_view.dart';

class DetailRouteListView extends StatelessWidget {
  const DetailRouteListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        itemCount: 100,
        itemBuilder: (context, index) {
          return Text('$index');
        },
        separatorBuilder: ((context, index) {
          return const Divider(height: 1);
        }),
      ),
    );
  }
}
