part of 'addschedule_example.dart';

final class MockAddScheduleView extends StatelessWidget {
  final homeDelegate = HomeDelegate();
  final addScheduleDelegate = AddScheduleDelegate();
  late final tokenEvent = EBTokenEvent(
    rootDelegate: RootDelegate(),
    loginDelegate: LoginDelegate(),
    ebTokenRepository: EBTokenRepository(),
  );
  late final scheduleEvent = ScheduleEvent(
    loadingDelegate: LoadingDelegate(),
    scheduleRepository: ScheduleRepository(),
    tokenEvent: tokenEvent,
  );

  MockAddScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: homeDelegate),
        RepositoryProvider.value(value: addScheduleDelegate),
        RepositoryProvider.value(value: scheduleEvent),
      ],
      child: MockAddScheduleBlocView(
        child: _child(),
      ),
    );
  }

  Widget _child() {
    return MockAddScheduleBlocView(
      child: MockModalBottomSheetButton(
        child: _modalView(),
      ),
    );
  }

  Widget _modalView() {
    return const AddScheduleContent();
    // return const MockAddScheduleScaffold(
    //   child: MockScheduleNameForm(),
    // );
  }
}

final class MockAddScheduleBlocView extends StatelessWidget {
  final Widget child;

  const MockAddScheduleBlocView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddScheduleBloc>(
      create: (context) {
        return AddScheduleBloc(
          homeDelegate: RepositoryProvider.of<HomeDelegate>(context),
          scheduleEvent: RepositoryProvider.of<ScheduleEvent>(context),
          addScheduleDelegate:
              RepositoryProvider.of<AddScheduleDelegate>(context),
          cancelModalViewAction: () => Navigator.of(context).pop(),
          // cancelModalViewAction: () {},
        );
      },
      child: child,
    );
  }
}

final class MockAddScheduleApp extends StatelessWidget {
  final Widget child;

  const MockAddScheduleApp({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
          ],
        ),
      ),
    );
  }
}

final class MockAddScheduleScaffold extends StatelessWidget {
  final Widget child;

  const MockAddScheduleScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
        ],
      ),
    );
  }
}
