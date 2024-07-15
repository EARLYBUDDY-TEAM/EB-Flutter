import 'package:earlybuddy/domain/delegate/searchplace.dart';
import 'package:earlybuddy/presentation/schedule/addschedule/bloc/bloc.dart';
import 'package:earlybuddy/presentation/schedule/addschedule/view/addschedule_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mock_addschedule.dart';

final class AddScheduleExample extends StatelessWidget {
  final _searchPlaceDelegateForPlace = SearchPlaceDelegateForPlace();
  final _searchPlaceDelegateForRoute = SearchPlaceDelegateForRoute();

  AddScheduleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _searchPlaceDelegateForPlace),
        RepositoryProvider.value(value: _searchPlaceDelegateForRoute),
      ],
      child: MaterialApp(
        home: _MockAddSchedule(),
      ),
    );
  }
}
