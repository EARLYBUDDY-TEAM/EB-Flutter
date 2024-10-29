part of '../eb_uikit.dart';

class ScrollWithHeader extends StatelessWidget {
  Widget header;
  double? headerHeight;
  List<Widget> list;
  Widget? defaultContent;

  ScrollWithHeader({
    super.key,
    required this.header,
    this.headerHeight,
    required this.list,
    this.defaultContent,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _slivers(),
    );
  }

  List<Widget> _slivers() {
    final List<Widget> listWidget = [_appBar()];

    final content = (defaultContent != null)
        ? _sliverFillRemaining(defaultContent!)
        : _sliverList();

    listWidget.add(content);

    return listWidget;
  }

  Widget _sliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(list),
    );
  }

  Widget _sliverFillRemaining(Widget child) {
    return SliverFillRemaining(
      child: Center(
        child: child,
      ),
    );
  }

  Widget _appBar() {
    return SliverAppBar(
      title: header,
      floating: true,
      toolbarHeight: headerHeight ?? 100,
      titleSpacing: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
    );
  }
}
