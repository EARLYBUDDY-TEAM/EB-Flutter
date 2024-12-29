part of '../home_example.dart';

final class MockMiddleTransportView extends StatelessWidget {
  final HomeRepositoryAB homeRepository = HomeRepository();

  MockMiddleTransportView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: homeRepository),
      ],
      child: const MockMiddleTransportBlocView(),
    );
  }
}

final class MockMiddleTransportBlocView extends StatelessWidget {
  const MockMiddleTransportBlocView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MiddleTranportBloc>(
      create: (context) {
        final realTimeInfoEvent = RealTimeInfoEvent(
          homeRepository: RepositoryProvider.of<HomeRepositoryAB>(context),
        );

        return MiddleTranportBloc(
          realTimeInfoEvent: realTimeInfoEvent,
        );
      },
      child: const MockMiddleTransportApp(
        // child: MockMiddleTransportInfoCard(),
        child: MockMiddleTransportArrivalCard(),
      ),
    );
  }
}

final class MockMiddleTransportApp extends StatelessWidget {
  final Widget child;

  const MockMiddleTransportApp({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child,
            ],
          ),
        ),
      ),
    );
  }
}
