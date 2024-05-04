part of '../navermap_view.dart';

final class _NaverMapSearchResultView extends StatelessWidget {
  BuildContext childContext2;

  _NaverMapSearchResultView({required this.childContext2});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      controller: ModalScrollController.of(childContext2),
      children: ListTile.divideTiles(
        context: childContext2,
        tiles: List.generate(
            100,
            (index) => ListTile(
                  title: const Text('Item'),
                  onTap: () {
                    Navigator.of(childContext2).push(
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
