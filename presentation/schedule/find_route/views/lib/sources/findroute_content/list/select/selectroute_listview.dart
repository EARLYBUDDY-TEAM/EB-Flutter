part of '../../../../eb_find_route.dart';

final class _SelectRouteListView extends StatelessWidget {
  final List<EBPath> ebPaths;
  final List<TransportLineOfPath> lineOfPaths;

  const _SelectRouteListView(
      {super.key, required this.ebPaths, required this.lineOfPaths});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(ebPaths.length + 1, (index) {
      if (index != ebPaths.length) {
        return Column(
          children: [
            InkWell(
              child: SelectRouteListItem(
                isBestRoute: (index < 3) ? true : false,
                ebPath: ebPaths[index],
                lineOfPath: lineOfPaths[index],
              ),
              onTap: () {
                context.read<FindRouteBloc>().add(
                      SetFindRouteContentStatus(
                        contentStatus: DetailFindRouteStatus(
                          selectedIndex: index,
                        ),
                      ),
                    );
              },
            ),
            _ListDivider(),
          ],
        );
      } else {
        return _OdsayImage();
      }
    }));
  }
}
