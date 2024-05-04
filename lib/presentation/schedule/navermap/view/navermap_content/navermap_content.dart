part of '../navermap_view.dart';

final class _NaverMapContent extends StatelessWidget {
  BuildContext childContext;

  _NaverMapContent({required this.childContext});

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
        body: _NaverMapSearchResultView(),
      ),
    );
  }
}
