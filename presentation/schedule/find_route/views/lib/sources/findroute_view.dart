part of '../eb_find_route.dart';

final class FindRouteView extends StatelessWidget {
  final Place start;
  final Place end;
  final String? parentName;
  Function()? backAction;
  Function()? cancelAction;

  FindRouteView({
    super.key,
    required this.start,
    required this.end,
    this.parentName,
    this.backAction,
    this.cancelAction,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FindRouteBloc(
        start: start,
        end: end,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _FindRouteAppBar(
          parentName: parentName,
          backAction: backAction,
          cancelAction: cancelAction,
        ),
        body: Column(
          children: [
            _FindRouteInfoView(
              startName: start.name,
              endName: end.name,
            ),
            const _FindRouteListView(),
          ],
        ),
      ),
    );
  }
}
