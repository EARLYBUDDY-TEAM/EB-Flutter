part of '../navermap_view.dart';

final class _NaverMapSearchResultView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      controller: ModalScrollController.of(context),
      children: ListTile.divideTiles(
        context: context,
        tiles: List.generate(
            100,
            (index) => ListTile(
                  title: const Text('네이버지도'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CupertinoPageScaffold(
                          navigationBar: const CupertinoNavigationBar(
                            middle: Text('New Page'),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              MaterialButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('touch here'),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
      ).toList(),
    );
  }
}
