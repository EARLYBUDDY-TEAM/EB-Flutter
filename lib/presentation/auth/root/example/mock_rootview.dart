part of 'root_example.dart';

final class _MockRootView extends StatelessWidget {
  final ebAuthRepository = MockEBAuthRepository();

  @override
  Widget build(BuildContext context) {
    return RootView(ebAuthRepository: ebAuthRepository);
  }
}

final class MockEBAuthRepository extends EBAuthRepository {
  @override
  Stream<AuthStatus> get authInfo async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield Authenticated.mock();
    yield* controller.stream;
  }
}
