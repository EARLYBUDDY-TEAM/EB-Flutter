// shrinkWrap: true,
//                 controller: ModalScrollController.of(childContext2),
part of 'eb_sources.dart';

class ScrollWithHeader extends StatelessWidget {
  Widget header;
  Widget Function(int) item;
  int length;

  ScrollWithHeader({
    super.key,
    required this.header,
    required this.item,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: header,
          floating: true,
          toolbarHeight: 100,
          titleSpacing: 0,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            List.generate(length, item),
          ),
        ),
      ],
    );
  }
}
