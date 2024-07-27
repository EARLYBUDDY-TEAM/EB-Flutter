part of 'eb_sources.dart';

class ScrollWithHeader extends StatelessWidget {
  Widget header;
  double? headerHeight;
  List<Widget> list;

  ScrollWithHeader({
    super.key,
    required this.header,
    this.headerHeight,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: header,
          floating: true,
          toolbarHeight: headerHeight ?? 100,
          titleSpacing: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
        ),
        SliverList(
          delegate: SliverChildListDelegate(list),
        ),
      ],
    );
  }
}
