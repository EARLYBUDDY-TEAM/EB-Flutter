part of '../../../../eb_find_route.dart';

final class _DetailRouteListView extends StatelessWidget {
  final List<EBSubPath> subPaths;

  const _DetailRouteListView({
    super.key,
    required this.subPaths,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FindRouteBloc, FindRouteState, SealedFindRouteSetting>(
      selector: (state) {
        return state.setting;
      },
      builder: (context, setting) {
        return Column(
          children: _list(
            context: context,
            subPaths: subPaths,
            setting: setting,
          ),
        );
      },
    );
  }

  List<Widget> _list({
    required BuildContext context,
    required List<EBSubPath> subPaths,
    required SealedFindRouteSetting setting,
  }) {
    return List.generate(subPaths.length + 1, (index) {
      if (index != subPaths.length) {
        return Column(
          children: [
            DetailRouteListItem(
              subPath: subPaths[index],
              setting: setting,
            ),
            _ListDivider(),
          ],
        );
      } else {
        return _OdsayImage();
      }
    });
  }
}
