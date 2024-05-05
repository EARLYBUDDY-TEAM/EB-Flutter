part of '../searchplace_view.dart';

final class _SearchPlaceListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('네이버지도'),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            // builder: (context) => CupertinoPageScaffold(
            //   navigationBar: const CupertinoNavigationBar(
            //     middle: Text('New Page'),
            //   ),
            //   child: Stack(
            //     fit: StackFit.expand,
            //     children: <Widget>[
            //       MaterialButton(
            //         onPressed: () => Navigator.of(context).pop(),
            //         child: const Text('touch here'),
            //       )
            //     ],
            //   ),
            // ),
            builder: (context) => const KakaoMapView(),
          ),
        );
      },
    );
  }
}
