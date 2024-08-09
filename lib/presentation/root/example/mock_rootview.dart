part of 'root_example.dart';

final class _MockRootView extends StatelessWidget {
  final MockEBAuthRepository mockEBAuthRepository;

  const _MockRootView({
    super.key,
    required this.mockEBAuthRepository,
  });

  @override
  Widget build(BuildContext context) {
    return RootView(ebAuthRepository: mockEBAuthRepository);
  }
}
