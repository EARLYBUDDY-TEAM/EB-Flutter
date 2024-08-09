import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/presentation/root/bloc/bloc.dart';
import 'package:earlybuddy/presentation/root/view/root_view.dart';
import 'package:flutter/material.dart';

part 'mock_rootview.dart';

class RootExample extends StatelessWidget {
  final MockEBAuthRepository mockEBAuthRepository;

  const RootExample({
    super.key,
    required this.mockEBAuthRepository,
  });

  @override
  Widget build(BuildContext context) {
    return _MockRootView(
      mockEBAuthRepository: mockEBAuthRepository,
    );
  }
}
