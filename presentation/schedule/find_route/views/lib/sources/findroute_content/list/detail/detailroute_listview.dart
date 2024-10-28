part of '../../../../eb_find_route.dart';

class _DetailRouteListView extends StatelessWidget {
  final List<EBSubPath> subPaths;

  const _DetailRouteListView({
    super.key,
    required this.subPaths,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _list(context),
    );
  }

  List<Widget> _list(BuildContext context) {
    return List.generate(subPaths.length + 1, (index) {
      if (index != subPaths.length) {
        return Column(
          children: [
            DetailRouteListItem(ebSubPath: subPaths[index]),
            _ListDivider(),
          ],
        );
      } else {
        return _OdsayImage();
      }
    });
  }
}
