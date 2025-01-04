part of '../findroute_example.dart';

final class _MockFindRouteListItem extends StatelessWidget {
  final HomeRepositoryAB homeRepository = HomeRepository();

  _MockFindRouteListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: homeRepository),
      ],
      child: _MockFindRouteListItemApp(
        child: _MockFindRouteListItemContent(),
        // child: _MockDetailStartInfoText(),
        // child: _MockDetailStartInfo(),
        // child: _MockDetailStartInfoPopupButtonContent(),
        // child: _MockDetailRouteBlocView(
        //   child: _MockStartInfoOther(),
        // ),
      ),
    );
  }
}

final class _MockDetailRouteBlocView extends StatelessWidget {
  final Widget child;

  const _MockDetailRouteBlocView({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailRouteBloc>(
      create: (context) {
        final realtimeInfoEvent = RealTimeInfoEvent(
          homeRepository: RepositoryProvider.of<HomeRepositoryAB>(context),
        );
        return DetailRouteBloc(
          realTimeInfoEvent: realtimeInfoEvent,
        );
      },
      child: child,
    );
  }
}

final class _MockStartInfoOther extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StartInfoOther(
      setting: ReadFindRouteSetting(path: EBPath.mock()),
      startName: mockStartName,
      fontSize: mockFontSize,
      startCoordi: Coordi.mockStart(),
      transportList: [mockSelectedTransport],
    );
  }
}

final class _MockFindRouteListItemApp extends StatelessWidget {
  final Widget child;

  const _MockFindRouteListItemApp({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

final class _MockFindRouteListItemContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DetailRouteListItem(
      subPath: _mockSubPath(),
      setting: ReadFindRouteSetting(
        path: EBPath.mock(),
      ),
    );
  }

  EBSubPath _mockSubPath() {
    return EBSubPath.mockWalk();
    // return EBSubPath.mockGasanToSuwon();
    // return EBSubPath.mockDongToGwang();
  }
}

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       children: [
//         Flexible(
//           child: Text(
//               'TextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextText',
//               overflow: TextOverflow.ellipsis),
//         ),
//         Icon(Icons.check),
//       ],
//     );
//   }
// }
