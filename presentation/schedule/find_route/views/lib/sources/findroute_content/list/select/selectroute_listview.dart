part of '../../../../eb_find_route.dart';

final class SelectRouteListView extends StatelessWidget {
  final List<EBPath> ebPaths;
  final List<TransportLineOfPath> lineOfPaths;

  const SelectRouteListView(
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
                ebPath: ebPaths[index],
                lineOfPath: lineOfPaths[index],
              ),
              onTap: () {
                final subPaths = ebPaths[index].ebSubPaths;
                context.read<FindRouteBloc>().add(
                      SetFindRouteContentStatus(
                        contentStatus: DetailFindRouteStatus(
                          subPaths: subPaths,
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
