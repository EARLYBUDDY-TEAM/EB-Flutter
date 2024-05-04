part of '../navermap_view.dart';

final class _NaverMapContent extends StatelessWidget {
  BuildContext childContext2;

  _NaverMapContent({required this.childContext2});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          title: _NaverMapSearchBar(),
          scrolledUnderElevation: 0,
          bottomOpacity: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: _NaverMapSearchResultView(childContext2: childContext2),
      ),
    );
  }
}
